#!/bin/bash

. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"
. "${SUIF_CACHE_HOME}/01.scripts/installation/setupFunctions.sh"

mkdir -p "${MY_binDir}"

if [ -f "${MY_installerSharedBin}" ]; then
  logI "Copying installer binary from the share"
  cp "${MY_installerSharedBin}" "${SUIF_INSTALL_INSTALLER_BIN}"
  logI "Installer binary copied"
else
  logI "Downloading default SUIF installer binary"
  assureDefaultInstaller "${SUIF_INSTALL_INSTALLER_BIN}"
  logI "Copying installer binary to the share"
  cp "${SUIF_INSTALL_INSTALLER_BIN}" "${MY_installerSharedBin}"
  logI "Installer binary copied, result $?"
fi

if [ -f "${MY_sumBootstrapSharedBin}" ]; then
  logI "Copying sum bootstrap binary from the share"
  cp "${MY_sumBootstrapSharedBin}" "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}"
  logI "SUM bootstrap binary copied"
else
  logI "Downloading default SUIF installer binary"
  assureDefaultSumBoostrap "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}"
  logI "Copying sum bootstrap to the share"
  cp "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}" "${MY_sumBootstrapSharedBin}"
  logI "SUM Bootstrap binary copied, result $?"
fi
chmod u+x "${SUIF_INSTALL_INSTALLER_BIN}"
chmod u+x "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}"

# Assure zips too

logI "Assuring zip image files for template ${JOB_SUIF_TEMPLATE}"

if [ ! -f "${SUIF_PRODUCT_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/products.zip" ]; then
  logE "File ${SUIF_PRODUCT_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/products.zip does not exist, cannot continue!"
  exit 1
fi

# determine the FIXES TAG

if [[ "${SUIF_FIXES_DATE_TAG}" == "latest" ]]; then
  SUIF_FIXES_DATE_TAG=$(ls -t "${SUIF_FIX_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}" | head -1)
  echo "##vso[task.setvariable variable=SUIF_FIXES_DATE_TAG;]${SUIF_FIXES_DATE_TAG}"
  export SUIF_FIXES_DATE_TAG
fi

logI "SUIF fixes date tag is: ${SUIF_FIXES_DATE_TAG}"

if [ "${SUIF_PATCH_AVAILABLE}" -eq 1 ]; then
  if [ ! -f "${SUIF_FIX_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/${SUIF_FIXES_DATE_TAG}/fixes.zip" ]; then
    logE "File ${SUIF_FIX_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/${SUIF_FIXES_DATE_TAG}/fixes.zip does not exist, cannot continue!"
    exit 2
  fi
  logI "Copying patch zip image from the share"
  cp "${SUIF_FIX_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/${SUIF_FIXES_DATE_TAG}/fixes.zip" "${SUIF_PATCH_FIXES_IMAGE_FILE}"
  logI "Patch zip image copied"
fi

logI "Copying installation zip image from the share"
cp "${SUIF_PRODUCT_IMAGES_SHARED_DIRECTORY}/${JOB_SUIF_TEMPLATE}/products.zip" "${SUIF_INSTALL_IMAGE_FILE}"
logI "Installation zip image copied"
