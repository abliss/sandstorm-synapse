#!/bin/bash

# When you change this file, you must take manual action. Read this doc:
# - https://docs.sandstorm.io/en/latest/vagrant-spk/customizing/#setupsh

set -xeuo pipefail
# This is the ideal place to do things like:
#
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y build-essential python3-dev libffi-dev \
  python3-pip python3-setuptools sqlite3 \
  libssl-dev python3-virtualenv libjpeg-dev libxslt1-dev \
  libpq-dev python3-virtualenv

virtualenv -p python3 env
source env/bin/activate
python -m pip install --no-use-pep517 -e .[all]

#
# If the packages you're installing here need some configuration adjustments,
# this is also a good place to do that:
#
#    sed --in-place='' \
#            --expression 's/^user www-data/#user www-data/' \
#            --expression 's#^pid /run/nginx.pid#pid /var/run/nginx.pid#' \
#            --expression 's/^\s*error_log.*/error_log stderr;/' \
#            --expression 's/^\s*access_log.*/access_log off;/' \
#            /etc/nginx/nginx.conf

# By default, this script does nothing.  You'll have to modify it as
# appropriate for your application.
exit 0
