#!/bin/bash
set -xeuo pipefail
# This script is run in the VM each time you run `vagrant-spk dev`.  This is
# the ideal place to invoke anything which is normally part of your app's build
# process - transforming the code in your repository into the collection of files
# which can actually run the service in production

# Python will only stat() foo.py, and if it's old, will only open() foo.pyc. This
# confuses spk-dev and causes os.py to not show up in sandstorm-files.list, so
# the packed .spk will fail with this cryptic message:
#   Could not find platform independent libraries <prefix>
# To avoid this, we freshen every single python file before starting spk-dev.

time find . -name '*.py' -exec touch '{}' ';'
exit 0
