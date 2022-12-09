#!/bin/bash

. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"

if [ ! -f "${SASECUREINFO_SECUREFILEPATH}" ]; then
  logE "Secure file path not present: ${SASECUREINFO_SECUREFILEPATH}"
  exit 2
fi

logI "Sourcing secure information: Storage Account coordinates and credentials..."
chmod u+x "${SASECUREINFO_SECUREFILEPATH}"
. "${SASECUREINFO_SECUREFILEPATH}"

if [ -z ${SAG_AZ_SA_NAME+x} ]; then
  logE "Secure information has not been sourced correctly: SAG_AZ_SA_NAME is missing!"
  exit 3
fi

if [ -z ${SAG_AZ_SA_KEY+x} ]; then
  logE "Secure information has not been sourced correctly: SAG_AZ_SA_KEY is missing!"
  exit 6
fi

if [ -z ${MY_sd+x} ]; then
  logE "Local environment information has not been sourced correctly: MY_sd is missing!"
  exit 4
fi

echo "Mounting the given file share"
mkdir -p "$MY_sd"
sudo mount -t cifs "${SAG_AZ_SMB_PATH}" "$MY_sd" -o "vers=3.0,username=${SAG_AZ_SA_NAME},password=${SAG_AZ_SA_KEY},dir_mode=0777,file_mode=0777"
resultMount=$?
if [ $resultMount -ne 0 ]; then
  logE "Error mounting the images share, result ${resultMount}"
  logE "Attempted to mount the SMB path ${SAG_AZ_SMB_PATH} using user ${SAG_AZ_SA_NAME}"
  exit 5
fi
