#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[LXD]==="
lxd-remove
lxd-deploy
echo ""

../scripts/init.sh "7.4"
