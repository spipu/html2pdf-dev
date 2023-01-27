#!/usr/bin/env bash

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][CLEAN]==="

PHP_VERSION="$1"

mkdir -p /home/delivery/dev/results/$PHP_VERSION
rm -f    /home/delivery/dev/results/$PHP_VERSION/*

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][EXAMPLES]==="

cd /home/delivery/dev/html2pdf/examples
for PHP_SCRIPT in $(ls ./*.php);
do
    PDF_FILE=`echo "$PHP_SCRIPT" | sed "s/\.php/\.pdf/g" | sed "s/\.\//\.\.\/\.\.\/results\/$PHP_VERSION\//g"`
    echo "Example $PHP_SCRIPT => $PDF_FILE"
    php $PHP_SCRIPT > $PDF_FILE
done

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][PHPUNIT]==="

cd /home/delivery/dev/html2pdf/
./vendor/bin/phpunit

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[TEST][FINISH]==="