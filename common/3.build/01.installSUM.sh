#!/bin/bash

. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"
. "${SUIF_CACHE_HOME}/01.scripts/installation/setupFunctions.sh"

logI "Installing Update Manager..."
mkdir -p "${SUIF_SUM_HOME}"
bootstrapSum "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}" "${SUIF_PATCH_FIXES_IMAGE_FILE}" "${SUIF_SUM_HOME}"
