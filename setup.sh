#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0);pwd)
cd ${SCRIPT_DIR}

# 権限を正しく付与しないとdockerにmountできない
mkdir jenkins_home
sudo chown -R 1000:1000 jenkins_home
sudo chmod -R 775 jenkins_home
