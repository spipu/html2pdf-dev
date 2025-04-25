#!/bin/bash

set -e

cd "$( dirname "${BASH_SOURCE[0]}" )"

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[INSTALL][CHECK VERSION]==="

php -v
composer --version

ln -s /var/www/html2pdf-dev ~/dev

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[INSTALL][START]==="

cd /var/www/html2pdf-dev/html2pdf
rm -rf ./composer.lock
rm -rf ./vendor
composer update

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[INSTALL][FINISH]==="
