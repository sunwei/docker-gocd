#!/bin/bash
set -e

BASEDIR="$(dirname "$0")"
WWW="$(cd ${BASEDIR}/../lib/letsencrypt && pwd)"
DOMAIN=

_issue_domain(){
  cd ${BASEDIR}/../lib/letsencrypt && pwd
  ./www -p create "${DOMAIN}"
}

_transfer_cert(){
  rm -rf /gocd-certs || true
  mkdir /gocd-certs && cd /gocd-certs
  cp "${WWW}/cert/${DOMAIN}-fullchain.csr" "./${DOMAIN}.crt"
  cp "${WWW}/cert/${DOMAIN}-private-key.pem" "./${DOMAIN}.key"
}

main(){
  DOMAIN="${1}"
  _issue_domain
  _transfer_cert
}

main "${@-}"
