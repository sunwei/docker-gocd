#!/bin/bash
set -e

BASEDIR="$(dirname "$0")"
PROJDIR="$(cd ${BASEDIR}/../ && pwd)"
CERTDIR="$(cd ${BASEDIR}/../cert && pwd)"
WWW="$(cd ${BASEDIR}/../lib/letsencrypt && pwd)"
GITCRYPT="$(cd ${BASEDIR}/../lib/git-crypt && pwd)"
DOMAIN=

_unlock_repo(){
  make export-key keyid=me@sunwei.xyz
  docker run --rm -it \
   --env GPGKEY=me@sunwei.xyz.asc \
   -v "${GITCRYPT}:/app/key" \
   -v "${PROJDIR}:/app/repo" \
   git-crypt \
  sh -c "cd ./lib/letsencrypt && make unlock"
}

_issue_domain(){
  ./www -p create "${DOMAIN}"
}

_transfer_cert(){
  cp "${WWW}/cert/${DOMAIN}-fullchain.csr" "${CERTDIR}/${DOMAIN}.crt"
  cp "${WWW}/cert/${DOMAIN}-private-key.pem" "${CERTDIR}/${DOMAIN}.key"
}

main(){
  DOMAIN="${1}"

  cd ${BASEDIR}/../lib/git-crypt && pwd
  _unlock_repo
  cd ..

  cd ./letsencrypt
  _issue_domain

  _transfer_cert
}

main "${@-}"
