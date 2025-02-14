#!/bin/sh

ENVIRONMENT=$1

if [[ "${ENVIRONMENT}" == "dev" ]]; then
  BASTION_ID=
  OCI_HOST=
  SSH_PUBLIC_KEY=
  SSH_PRIVATE_KEY=
fi

if [[ "${ENVIRONMENT}" == "sbx" ]]; then
  BASTION_ID=
  OCI_HOST=
  SSH_PUBLIC_KEY=
  SSH_PRIVATE_KEY=
fi

if [[ "${ENVIRONMENT}" == "prd" ]]; then
  BASTION_ID=
  OCI_HOST=
  SSH_PUBLIC_KEY=
  SSH_PRIVATE_KEY=
fi

TARGET_TYPE=$2

if [[ "${TARGET_TYPE}" == "oke" ]]; then
  if [[ "${ENVIRONMENT}" == "dev" ]]; then
    TARGET_PRIVATE_IP=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "sbx" ]]; then
    TARGET_PRIVATE_IP=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "prd" ]]; then
    TARGET_PRIVATE_IP=
    TARGET_PORT=
  fi
fi

LOCAL_IP=$3
LOCAL_PORT=$4

KEY_TYPE=PUB
SESSION_TTL=10800

echo "Creating session..."

SESSION_ID=`oci bastion session create-port-forwarding\
            --bastion-id ${BASTION_ID}\
            --key-type ${KEY_TYPE}\
            --session-ttl ${SESSION_TTL}\
            --ssh-public-key-file ${SSH_PUBLIC_KEY}\
            --target-private-ip ${TARGET_PRIVATE_IP}\
            --target-port ${TARGET_PORT}\
            | jq '.data.id'`

SESSION_ID=`echo ${SESSION_ID} | tr -d '"'`

echo "Session created"

echo "Waiting session to be activated..."

while [ `oci bastion session get --session-id ${SESSION_ID} | jq '.data."lifecycle-state"' | tr -d '"'` != "ACTIVE" ]; do
  echo "Session not activeted yet. Retrying..."
  sleep 5
done

echo "Session activated"

echo "Session ${SESSION_ID} created"

echo "Connecting to bastion..."

sleep 10

ssh -i ${SSH_PRIVATE_KEY} -N -L ${LOCAL_IP}:${LOCAL_PORT}:${TARGET_PRIVATE_IP}:${TARGET_PORT} -p 22 ${SESSION_ID}@${OCI_HOST} -v