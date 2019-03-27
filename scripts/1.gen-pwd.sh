#!/bin/bash
set -e

BASEDIR="$(dirname "$0")"
SECRETS_DIR="$(cd ${BASEDIR}/../secrets && pwd)"

USERS_FILE="${SECRETS_DIR}/users.env"
PWD_FILE="${SECRETS_DIR}/password.properties"

while IFS='' read -r line || [[ -n "$line" ]]; do
  username="$(echo ${line} | awk -F '=' '{print $1}')"
  password="$(echo ${line} | awk -F '=' '{print $2}')"

  if [[ -e "${PWD_FILE}" ]]; then
    htpasswd -B -b "${PWD_FILE}" "${username}" "${password}"
  else
    htpasswd -c -B -b "${PWD_FILE}" "${username}" "${password}"
  fi
done < "${USERS_FILE}"