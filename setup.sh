#!/bin/bash

SCTIPR_DIR=$(cd $(dirname $0);pwd)
cd ${SCTIPR_DIR}

# 権限を正しく付与しないとdockerにmountできない
mkdir jenkins_home
sudo chown -R 1000:1000 jenkins_home
sudo chmod -R 775 jenkins_home
