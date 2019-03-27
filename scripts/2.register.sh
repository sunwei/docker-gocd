#!/bin/bash
set -e

if [[ "${ENV}" = "prod" ]]; then
 www -p "${FQDN}"
else
 www "${FQDN}"
fi

(curl --fail -i 'http://localhost:8153/go/api/admin/security/auth_configs' \\
  -H 'Accept: application/vnd.go.cd.v1+json' \\
  -H 'Content-Type: application/json' \\
  -X POST -d '{
    "id": "auth-file-config",
    "plugin_id": "cd.go.authentication.passwordfile",
    "properties": [
      {
        "key": "PasswordFilePath",
        "value": "/etc/go-users"
      }
    ]
  }')

# Put the default dhparam file in place so we can start immediately
cp $PREGEN_DHPARAM_FILE $DHPARAM_FILE
touch $GEN_LOCKFILE
# Generate a new dhparam in the background in a low priority and reload nginx when finished (grep removes the progress indicator).
(
    (
        nice -n +5 openssl dhparam -out $DHPARAM_FILE.tmp $DHPARAM_BITS 2>&1 \
        && mv $DHPARAM_FILE.tmp $DHPARAM_FILE \
        && echo "dhparam generation complete, reloading nginx" \
        && nginx -s reload
    ) | grep -vE '^[\.+]+'
    rm $GEN_LOCKFILE
) &disown