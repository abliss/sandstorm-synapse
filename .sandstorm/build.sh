#!/bin/bash
set -xeuo pipefail
# This script is run in the VM each time you run `vagrant-spk dev`.  This is
# the ideal place to invoke anything which is normally part of your app's build
# process - transforming the code in your repository into the collection of files
# which can actually run the service in production

cd /opt/app

python3 -m virtualenv -p python3 env
# python devs don't understand bash
export PS1=''

source env/bin/activate
python -m pip install --no-use-pep517 -e .[all]

exit 0
