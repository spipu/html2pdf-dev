#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )"

if [[ "$1" == "" ]]; then
  echo "ERROR - you must not use this script directly"
  exit 1
fi

if [[ ! -d "../html2pdf" ]]; then
  git clone git@github.com:spipu/html2pdf.git ../html2pdf
fi

echo "====[PHP $1]========================"

lxd-remove
lxd-deploy

ssh root@html2pdf-dev.lxd     /home/delivery/dev/scripts/include/provision.sh "$1"
ssh delivery@html2pdf-dev.lxd /home/delivery/dev/scripts/include/install.sh   "$1"
ssh delivery@html2pdf-dev.lxd /home/delivery/dev/scripts/include/test.sh      "$1"





