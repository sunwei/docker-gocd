#!/bin/bash
set -e

BASEDIR="$(dirname "$0")"
ROOT_DIR="$(cd ${BASEDIR}/../ && pwd)"


main(){
  REMOTE_HOST="${1}"
  cd ${BASEDIR}/../
  tar -czvf "${ROOT_DIR}/tmp.tar" .
  scp -r "${ROOT_DIR}/tmp.tar" "root@${REMOTE_HOST}:/home/docker-gocd.tar"
#  ssh root@ihakula.com
#  cd /home
#  rm -rf cicd || true
#  mkdir cicd
#  tar -xzvf docker-gocd.tar -C /home/cicd
#  cd /home/cicd
}

main "${@-}"
