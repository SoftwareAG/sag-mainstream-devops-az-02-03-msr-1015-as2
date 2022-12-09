#!/bin/bash

# Pipeline parameters
# These should be received, but set some value just in case...
export JOB_SUIF_TAG=${JOB_SUIF_TAG:-"main"}
export MY_AZ_ACR_URL=${MY_AZ_ACR_URL:-"gccdevopsacr.azurecr.io"}
#export MY_FIXES_TAG=${MY_FIXES_TAG:-'latest'}
export JOB_DATE=${JOB_DATE:-$(date +%y-%m-%d'T'%H.%M.%S_%3N)}
export JOB_DATETIME=${JOB_DATETIME:-$(date +%y-%m-%d)}

# local constants / variables
export MY_sd="/tmp/share"   # share directory - images
export MY_binDir="$MY_sd/bin"
export MY_installerSharedBin="$MY_binDir/installer.bin"
export MY_sumBootstrapSharedBin="$MY_binDir/sum-bootstrap.bin"

# SUIF exports
export SUIF_AUDIT_BASE_DIR=/tmp/SUIF_AUDIT
# ATTN: SUIF_DEBUG_ON=1 produces more logs, but may leave some functions waiting for user input
#       do not use it for unattended "final" forms of the pipelines
export SUIF_CACHE_HOME="/tmp/SUIF_CACHE"
export SUIF_DEBUG_ON=${SUIF_DEBUG_ON:-0} # Expect this to be a pipeline parameter
export SUIF_FIX_IMAGES_SHARED_DIRECTORY="$MY_sd/fixes"
export SUIF_HOME_URL="https://raw.githubusercontent.com/SoftwareAG/sag-unattented-installations/${JOB_SUIF_TAG}"
export SUIF_INSTALL_IMAGE_FILE="/tmp/products.zip"
export SUIF_INSTALL_INSTALL_DIR="/opt/softwareag"
export SUIF_INSTALL_INSTALLER_BIN="/tmp/installer.bin"
export SUIF_PATCH_AVAILABLE=1 # we always have patches available, with exception of very small time intervals
export SUIF_PATCH_FIXES_IMAGE_FILE="/tmp/fixes.zip"
export SUIF_PATCH_SUM_BOOSTSTRAP_BIN="/tmp/sum-bootstrap.bin"
export SUIF_PRODUCT_IMAGES_SHARED_DIRECTORY="$MY_sd/products"
export SUIF_SDC_ONLINE_MODE=0 # tell SUIF we are NOT downloading from SDC, but install from given images
export SUIF_SUM_HOME=/tmp/sumv11
