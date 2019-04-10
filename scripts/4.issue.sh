#!/bin/bash
set -e

BASEDIR="$(dirname "$0")"
PROJDIR="$(cd ${BASEDIR}/../ && pwd)"
CERTDIR="$(cd ${BASEDIR}/../cert && pwd)"
WWW="$(cd ${BASEDIR}/../lib/letsencrypt && pwd)"
DOMAIN=

_unlock_repo(){
  docker run --rm -it \
   -v "${1}:/app/key/gpg-private.asc" \
   -v "${PROJDIR}:/app/repo" \
   git-crypt \
  sh -c "cd ./lib/letsencrypt && make unlock"
}

_issue_domain(){
  ./www create -p "${DOMAIN}"
}

_transfer_cert(){
  cp "${WWW}/cert/${DOMAIN}-fullchain.csr" "${CERTDIR}/${DOMAIN}.crt"
  cp "${WWW}/cert/${DOMAIN}-private-key.pem" "${CERTDIR}/${DOMAIN}.key"
}

main(){
  DOMAIN="${1}"
  GPGKEY="${2}"

  _unlock_repo "${GPGKEY}"

  cd ${BASEDIR}/../lib/letsencrypt && pwd
  _issue_domain

  _transfer_cert
}

main "${@-}"
