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
    [[ ! ${line} =~ ^(HOSTNAME=|HOME=|INPUT_) ]] && printf '%s\n' "${line}" >> ~/script.sh
done
echo '' >> ~/script.sh
echo '# Commands:' >> ~/script.sh
echo "${INPUT_COMMAND}" >> ~/script.sh

echo ""
echo -e "${BLUE}Run on:${NORMAL} ${INPUT_HOSTS}"
echo -e "${BLUE}Commands:${NORMAL}"
cat ~/script.sh
echo ""

for host in ${INPUT_HOSTS}; do
  echo -e "${BLUE}Connecting to ${host}...${NORMAL}"
  sh -c "ssh -q -t -i ~/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no '${host}' < ~/script.sh"
  echo ""
done

echo ""
echo -e "${BLUE}GitHub Action completed.${NORMAL}"