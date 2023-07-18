#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [[ "$1" == "" ]]; then
  echo "ERROR - you must not use this script directly"
  exit 1
fi

if [[ ! -d "../html2pdf" ]]; then
  git clone git@github.com:spipu/html2pdf.git ../html2pdf
fi

PHP_VERSION="$1"
mkdir -p ../results
if [[ -d "../results/$PHP_VERSION" ]]; then
  rm -rf ../results/$PHP_VERSION
fi

echo "====[PHP $PHP_VERSION]========================"

lxd-remove
lxd-deploy

ssh root@html2pdf-dev.lxd     /var/www/html2pdf-dev/scripts/include/provision.sh "$PHP_VERSION"
ssh delivery@html2pdf-dev.lxd /var/www/html2pdf-dev/scripts/include/install.sh   "$PHP_VERSION"
ssh delivery@html2pdf-dev.lxd /var/www/html2pdf-dev/scripts/include/test.sh      "$PHP_VERSION"

