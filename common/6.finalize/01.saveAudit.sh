#!/bin/bash

. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"

logI "Saving the audit"
mkdir -p "$MY_sd/sessions/$JOB_DATE"
tar cvzf "$MY_sd/sessions/$JOB_DATE/s_$JOB_DATETIME.tgz" "${SUIF_AUDIT_BASE_DIR}"
