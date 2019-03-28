#!/bin/bash
set -e

GO_SERVER="http://localhost:8153"
GO_SERVER_AUTH_CONF_API="${GO_SERVER}/go/api/admin/security/auth_configs"

setup_users(){
  echo "> Setup users for go server..."
  curl --fail -i "${GO_SERVER_AUTH_CONF_API}" \
    -H 'Accept: application/vnd.go.cd.v1+json' \
    -H 'Content-Type: application/json' \
    -X POST -d '{
      "id": "auth-file-config",
      "plugin_id": "cd.go.authentication.passwordfile",
      "properties": [
        {
          "key": "PasswordFilePath",
          "value": "/etc/go-users"
        }
      ]
    }'
}

resCode=0
wait_for_go_server_up(){
  while [[ "${resCode:0:1}" != 2 ]]; do
    resCode="$(curl -i -L -s -o /dev/null -w "%{http_code}" "${GO_SERVER}")"
    echo "> Waiting for go server up..."
    sleep 5;
  done
}

wait_for_go_server_up && setup_users