#!/bin/bash

. ./setEnv.sh
. "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"

logI "Updating OS software"
sudo apt -y update

logI "Updating base libraries..."
sudo apt-get -y update
logI "Installing prerequisites..."
sudo apt-get install -y ca-certificates curl gnupg2 fuse-overlayfs
. /etc/os-release
logI "Installing buildah for OS release ${VERSION_ID}..."
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -fsL "https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key" | sudo apt-key add - &&
sudo apt-get -qq -y update
sudo apt-get -qq -y install buildah
logI "Machine prepared"
