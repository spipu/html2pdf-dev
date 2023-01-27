#!/bin/bash

cd /tmp

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][START]==="

PHP_VERSION="$1"
PHP_FOLDER="/etc/php/${PHP_VERSION}"

export DEBIAN_FRONTEND=noninteractive

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][UPGRADE]==="

apt-get -qq update          > /dev/null
apt-get -qq -y dist-upgrade > /dev/null
apt-get -qq -y autoremove   > /dev/null

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][PACKAGES]==="

apt-get -qq -y install \
    sudo lsb-release inetutils-ping curl vim bash-completion \
    less lsof file unzip ntp acpid tar wget zip > /dev/null

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][PHP ${PHP_VERSION}]==="

apt-get -qq -y install php-cli php-common php-bcmath php-curl php-gd \
    php-iconv php-intl php-json php-mbstring php-readline \
    php-simplexml php-soap php-xml php-xsl php-zip > /dev/null

rm -f ${PHP_FOLDER}/cli/conf.d/99-provision.ini
cp /home/delivery/dev/scripts/conf/php.ini ${PHP_FOLDER}/cli/conf.d/99-provision.ini


HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][COMPOSER]==="

wget -q https://getcomposer.org/download/latest-stable/composer.phar
mv ./composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][CHECK VERSION]==="

echo ""
php -v
echo ""
composer --version
echo ""

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][FINISH]==="

export DEBIAN_FRONTEND=dialog
