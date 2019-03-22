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


# TODO
1. generate gocd password file
2. run gocd with docker and set password succeed
3. sign domain
4. run with docker compose