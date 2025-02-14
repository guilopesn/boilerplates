#!/bin/sh

ENVIRONMENT=$1

if [[ "${ENVIRONMENT}" == "dev" ]]; then
  BASTION_USER=
  BASTION_HOST=
  BASTION_PRIVATE_KEY=
fi

if [[ "${ENVIRONMENT}" == "sbx" ]]; then
  BASTION_USER=
  BASTION_HOST=
  BASTION_PRIVATE_KEY=
fi

if [[ "${ENVIRONMENT}" == "prd" ]]; then
  BASTION_USER=
  BASTION_HOST=
  BASTION_PRIVATE_KEY=
fi

TARGET_TYPE=$2

if [[ "${TARGET_TYPE}" == "eks" ]]; then
  if [[ "${ENVIRONMENT}" == "dev" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "sbx" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "prd" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi
fi

if [[ "${TARGET_TYPE}" == "docdb" ]]; then
  if [[ "${ENVIRONMENT}" == "dev" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "sbx" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "prd" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi
fi

if [[ "${TARGET_TYPE}" == "rds" ]]; then
  if [[ "${ENVIRONMENT}" == "dev" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "sbx" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi

  if [[ "${ENVIRONMENT}" == "prd" ]]; then
    TARGET_HOST=
    TARGET_PORT=
  fi
fi

LOCAL_IP=$3
LOCAL_PORT=$4

echo "Connecting to bastion ${BASTION_HOST} of environment ${ENVIRONMENT}..."

ssh -i "${BASTION_PRIVATE_KEY}" -N -L ${LOCAL_IP}:${LOCAL_PORT}:${TARGET_HOST}:${TARGET_PORT} ${BASTION_USER}@${BASTION_HOST} -v
