# for switching between vagrant-spk and spk

# Without a HOME, I get:
#   File "/usr/lib/python3.5/sysconfig.py", line 546, in get_config_vars
#     _CONFIG_VARS['userbase'] = _getuserbase()
#   File "/usr/lib/python3.5/sysconfig.py", line 205, in _getuserbase
#     return joinuser("~", ".local")
#   File "/usr/lib/python3.5/sysconfig.py", line 184, in joinuser
#     return os.path.expanduser(os.path.join(*args))
#   File "/usr/lib/python3.5/posixpath.py", line 238, in expanduser
#     userhome = pwd.getpwuid(os.getuid()).pw_dir
# KeyError: 'getpwuid(): uid not found: 1653'
export HOME="${HOME-/var}"

ENV_NAME="env"
PIP_ARGS=("--no-use-pep517")
if [ ! -d "${ENV_NAME}" ]; then
    cd /opt/app
    ENV_NAME="env_optapp"
    PIP_ARGS=()
fi
if [ ! -d "${ENV_NAME}" ]; then
    python3 -m venv "${ENV_NAME}"
fi
# python venv devs don't understand bash
oldstate="$(set +o); set -$-" # POSIXly store all set options
set +eu
source ${ENV_NAME}/bin/activate
set -vx; eval "$oldstate" # Restore old state

