#!/bin/bash
set -euxo pipefail
source env/bin/activate
python3 -m synapse.app.homeserver \
    --server-name FIXME.rapidraven.sandcats.io \
    --config-path homeserver.yaml \
    --generate-config \
    --report-stats=no

