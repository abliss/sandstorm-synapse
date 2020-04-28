#!/bin/bash

# When you change this file, you must take manual action. Read this doc:
# - https://docs.sandstorm.io/en/latest/vagrant-spk/customizing/#setupsh

set -xeuo pipefail
# This is the ideal place to do things like:
#
if which sqlite3 ; then
    echo "Assuming already installed."
else
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y build-essential python3-dev libffi-dev \
            python3-pip python3-setuptools sqlite3 \
            libssl-dev python3-venv libjpeg-dev libxslt1-dev \
            libpq-dev
fi
OLD_PWD=$(pwd)
cd /opt/app/.sandstorm
PIP_ARGS=()
. activate.sh
python3 -m pip install "${PIP_ARGS[@]}" -e .[all]


