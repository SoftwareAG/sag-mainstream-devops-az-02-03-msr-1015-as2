#!/bin/bash

# run from the folder containing setEnv.sh
. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"

logI "Downloading the build from SUIF..."

huntForSuifFile "05.docker-image-builders/MSR/1015/msr-as2-custom-builder-01" "Dockerfile" || exit 1
huntForSuifFile "05.docker-image-builders/MSR/1015/msr-as2-custom-builder-01" "install.sh" || exit 2

logI "Preparing the build context..."
mkdir /tmp/build_context

mv "${SUIF_CACHE_HOME}/05.docker-image-builders/MSR/1015/msr-as2-custom-builder-01/"* /tmp/build_context/
mv "${SUIF_INSTALL_IMAGE_FILE}" /tmp/build_context/products.zip
mv "${SUIF_INSTALL_INSTALLER_BIN}" /tmp/build_context/installer.bin
mv "${SUIF_PATCH_FIXES_IMAGE_FILE}" /tmp/build_context/fixes.zip
mv "${SUIF_PATCH_SUM_BOOSTSTRAP_BIN}" /tmp/build_context/sum-bootstrap.bin
cp "${MSRLICENSE_SECUREFILEPATH}" /tmp/build_context/msr-license.xml
cp "${BRMSLICENSE_SECUREFILEPATH}" /tmp/build_context/brms-license.xml

export JOB_CONTAINER_BASE_TAG="${MY_AZ_ACR_URL}/msr-1015-as2-custom-recipe1:Fixes_${SUIF_FIXES_DATE_TAG}"
export JOB_CONTAINER_MAIN_TAG="${JOB_CONTAINER_BASE_TAG}_BUILD_${JOB_DATETIME}"

echo "##vso[task.setvariable variable=JOB_CONTAINER_MAIN_TAG;]${JOB_CONTAINER_MAIN_TAG}"
echo "##vso[task.setvariable variable=JOB_CONTAINER_BASE_TAG;]${JOB_CONTAINER_BASE_TAG}"

cd /tmp/build_context || exit 3

if [ ! -f "Dockerfile" ]; then
  logE "No Dockerfile, cannot continue"
  exit 4
fi

logI "Building container"
buildah \
  --storage-opt mount_program=/usr/bin/fuse-overlayfs \
  --storage-opt ignore_chown_errors=true \
  bud --format docker -t "${JOB_CONTAINER_MAIN_TAG}"
  
resultBuildah=$?

if [ $resultBuildah -ne 0 ]; then
  logE "buildah bud failed with code $resultBuildah"

  logI "listing build context"

  ls -lart .

  logE "cat Dockerfile"
  cat Dockerfile
  exit 5
fi

logI "Container image JOB_CONTAINER_MAIN_TAG built"
