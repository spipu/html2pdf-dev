#!/bin/bash

set -e

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
    less lsof file unzip ntp acpid tar wget zip \
    apt-transport-https lsb-release ca-certificates software-properties-common > /dev/null

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][ADD SURY]==="

LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php > /dev/null
apt-get -qq update > /dev/null

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][PHP ${PHP_VERSION}]==="

apt-get -qq -y install \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-imagick \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-readline \
    php${PHP_VERSION}-simplexml \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xsl \
    php${PHP_VERSION}-zip \
    > /dev/null

if (( $(echo "8.0 $PHP_VERSION" | awk '{print ($1 > $2)}') )); then
  apt-get -qq -y install php${PHP_VERSION}-json > /dev/null
fi

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][APACHE]==="
apt-get -qq -y install apache2 libapache2-mod-php${PHP_VERSION} > /dev/null

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][CONFIGURE PHP]==="

rm -f ${PHP_FOLDER}/cli/conf.d/99-provision.ini
rm -f ${PHP_FOLDER}/apache2/conf.d/99-provision.ini
cp /var/www/html2pdf-dev/scripts/conf/php.ini ${PHP_FOLDER}/cli/conf.d/99-provision.ini
cp /var/www/html2pdf-dev/scripts/conf/php.ini ${PHP_FOLDER}/apache2/conf.d/99-provision.ini


HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][CONFIGURE APACHE]==="

rm -f /etc/apache2/sites-available/000-default.conf
cp /var/www/html2pdf-dev/scripts/conf/virtualhost.conf /etc/apache2/sites-available/000-default.conf
systemctl restart apache2

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][COMPOSER]==="

COMPOSER_URL="https://getcomposer.org/download/latest-stable/composer.phar"
if (( $(echo "7.2 $PHP_VERSION" | awk '{print ($1 > $2)}') )); then
  COMPOSER_URL="https://getcomposer.org/download/latest-2.2.x/composer.phar"
fi
wget -q "$COMPOSER_URL"
mv ./composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

HOUR=$(date +%H:%M:%S)
echo "[${HOUR}]===[PROVISION][FINISH]==="

export DEBIAN_FRONTEND=dialog
