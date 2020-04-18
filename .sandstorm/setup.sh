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
python3 -m pip install --no-use-pep517 -e .[all]

