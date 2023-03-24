#!/bin/bash

set -eu

BLUE='\033[0;34m'
NORMAL='\033[0m'


mkdir -p ~/.ssh/
install -m 600 /dev/null ~/.ssh/id_rsa
echo "${INPUT_PRIVATEKEY}" > ~/.ssh/id_rsa

install -m 700 /dev/null ~/script.sh
echo '# Environment variables:' >> ~/script.sh
env -0 | while read -r -d '' line; do
    # Skip unnecessary env vars, wrap the single- or multiline value in single quotes, escape existing single quotes.
    [[ ! ${line} =~ ^(HOSTNAME=|HOME=|INPUT_) ]] && echo "${line%%=*}='$(echo "${line#*=}" | sed "s/'/'\\\\''/g")'" >> ~/script.sh
done
echo '' >> ~/script.sh
echo '# Commands:' >> ~/script.sh
echo "${INPUT_COMMAND}" >> ~/script.sh

echo ""
echo -e "${BLUE}Run on:${NORMAL} ${INPUT_HOSTS}"
echo -e "${BLUE}Commands:${NORMAL}"
if [[ "${INPUT_DEBUG}" = "true" ]] || [[ "${INPUT_DEBUG}" = "1" ]]; then
    cat ~/script.sh
else
    cat ~/script.sh | sed '1,/^# Commands:$/d'
fi
echo ""

for host in ${INPUT_HOSTS}; do
    echo -e "${BLUE}Connecting to ${host}...${NORMAL}"
    PORT=$(echo "$host" | cut -s -d':' -f2 | sed 's/[^0-9]//g')
    sh -c "ssh -q -t -i ~/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '${host%%:*}' -p ${PORT:-22} < ~/script.sh"
    echo ""
done

echo ""
echo -e "${BLUE}GitHub Action completed.${NORMAL}"
