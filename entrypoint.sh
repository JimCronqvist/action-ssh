#!/bin/sh

set -eu

mkdir -p ~/.ssh/
install -m 600 "${INPUT_PRIVATEKEY}" ~/.ssh/id_rsa
install -m 700 "${INPUT_COMMAND}" ~/script.sh

echo "Run on: ${INPUT_HOSTS}"
echo "Commands:"
cat ~/script.sh

for host in "${INPUT_HOSTS}"; do
  sh -c "ssh -t -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no '${host}' < ~/script.sh"
done

echo "Completed"