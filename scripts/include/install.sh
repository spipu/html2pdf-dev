#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[INSTALL][START]==="

cd /home/delivery/dev/html2pdf
rm -rf ./composer.lock
rm -rf ./vendor
composer update

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[INSTALL][FINISH]==="
