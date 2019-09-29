#!/bin/sh

set -eu

BLUE='\033[0;34m'
NORMAL='\033[0m'


mkdir -p ~/.ssh/
install -m 600 /dev/null ~/.ssh/id_rsa
echo "${INPUT_PRIVATEKEY}" > ~/.ssh/id_rsa
install -m 700 /dev/null ~/script.sh
echo "${INPUT_COMMAND}" > ~/script.sh

echo ""
echo -e "${BLUE}Run on: ${INPUT_HOSTS}${NORMAL}"
echo -e "${BLUE}Commands:${NORMAL}"
cat ~/script.sh
echo ""

for host in ${INPUT_HOSTS}; do
  echo -e "${BLUE}Connecting to ${host}...${NORMAL}"
  sh -c "ssh -t -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no '${host}' < ~/script.sh"
done

echo ""
echo -e "${BLUE}GitHub Action completed.${NORMAL}"