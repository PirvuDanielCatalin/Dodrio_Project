#!/bin/bash

function change_admin_password() {
    local NEXUS_URL=$1
    local NEXUS_OLD_PWD=$2
    local NEXUS_NEW_PWD=$3
    shift 3
    local CURL_OPTS="$@"
    local SCRIPT_NAME=change-nexus-admin-password

    read -r -d '' SCRIPT_JSON <<EOF
{
  "name": "${SCRIPT_NAME}",
  "type": "groovy",
  "content": "security.securitySystem.changePassword('admin', args)"
}
EOF

    CHECK_SCRIPT_STATUS=$(curl ${CURL_OPTS} -s -o /dev/null -I -w "%{http_code}" -u "admin:${NEXUS_OLD_PWD}" "${NEXUS_URL}/service/siesta/rest/v1/script/${SCRIPT_NAME}")

    if [ "${CHECK_SCRIPT_STATUS}" == "404" ]; then
        echo "> ${SCRIPT_NAME} is not found (${CHECK_SCRIPT_STATUS})"
        echo "> Creating script (${SCRIPT_NAME}) ..."
        curl ${CURL_OPTS} -H "Accept: application/json" -H "Content-Type: application/json" -d "${SCRIPT_JSON}" -u "admin:${NEXUS_OLD_PWD}" "${NEXUS_URL}/service/siesta/rest/v1/script/"
    elif [ "${CHECK_SCRIPT_STATUS}" == "401" ]; then
        echo "> Unauthorized (${CHECK_SCRIPT_STATUS})"
        return
    else
        echo "> ${SCRIPT_NAME} is found (${CHECK_SCRIPT_STATUS})"
        echo "> Updating script (${SCRIPT_NAME}) ..."
        curl ${CURL_OPTS} -XPUT -H "Accept: application/json" -H "Content-Type: application/json" -d "${SCRIPT_JSON}" -u "admin:${NEXUS_OLD_PWD}" "${NEXUS_URL}/service/siesta/rest/v1/script/${SCRIPT_NAME}"
    fi

    echo "> Updating password ..."
    CHECK_RUN_STATUS=$(curl ${CURL_OPTS} -s -o /dev/null -w "%{http_code}" -H "Content-Type: text/plain" -u "admin:${NEXUS_OLD_PWD}" "${NEXUS_URL}/service/siesta/rest/v1/script/${SCRIPT_NAME}/run" -d "${NEXUS_NEW_PWD}")

    if [ "${CHECK_RUN_STATUS}" == "200" ]; then
        echo "> Succeeded!"
    else
        echo "> Failed! (${CHECK_RUN_STATUS})"
    fi
}
