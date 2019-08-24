#!/bin/bash

APP_NAME=web
SRC_DIR=${HOME}/cabin/${APP_NAME}
DEST_DIR=${HOME}/repo/apps/${APP_NAME}

cp -pR ${SRC_DIR}/.bundle ${DEST_DIR}
cp -p ${SRC_DIR}/Gemfile.lock ${DEST_DIR}
cp -p ${SRC_DIR}/yarn.lock ${DEST_DIR}
ln -s ${SRC_DIR}/node_modules ${DEST_DIR}
