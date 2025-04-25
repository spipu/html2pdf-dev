#!/usr/bin/env bash

set -e

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][CLEAN]==="

PHP_VERSION="$1"

mkdir -p /var/www/html2pdf-dev/results/$PHP_VERSION
rm -f    /var/www/html2pdf-dev/results/$PHP_VERSION/*

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][EXAMPLES]==="

cd /var/www/html2pdf-dev/html2pdf/examples
for PHP_SCRIPT in $(ls ./*.php);
do
    PDF_FILE=`echo "$PHP_SCRIPT" | sed "s/\.php/\.pdf/g" | sed "s/\.\//\.\.\/\.\.\/results\/$PHP_VERSION\//g"`
    echo "Example $PHP_SCRIPT => $PDF_FILE"
    php $PHP_SCRIPT > $PDF_FILE

    if ! head -c 8 "$PDF_FILE" | grep -q '^%PDF-1\.7'; then
        echo " => ERROR - the result file is not a PDF"
        exit 1
    fi
done

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][PHPUNIT]==="

cd /var/www/html2pdf-dev/html2pdf/
./vendor/bin/phpunit

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][FINISH]==="