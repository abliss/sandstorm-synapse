#!/bin/bash
set -xeuo pipefail
# This script is run every time an instance of our app - aka grain - starts up.
# This is the entry point for your application both when a grain is first launched
# and when a grain resumes after being previously shut down.
#
# This script is responsible for launching everything your app needs to run.  The
# thing it should do *last* is:
#
#   * Start a process in the foreground listening on port 8000 for HTTP requests.
#
# This is how you indicate to the platform that your application is up and
# ready to receive requests.  Often, this will be something like nginx serving
# static files and reverse proxying for some other dynamic backend service.
#
# Other things you probably want to do in this script include:
#
#   * Building folder structures in /var.  /var is the only non-tmpfs folder
#     mounted read-write in the sandbox, and when a grain is first launched, it
#     will start out empty.  It will persist between runs of the same grain, but
#     be unique per app instance.  That is, two instances of the same app have
#     separate instances of /var.
#   * Preparing a database and running migrations.  As your package changes
#     over time and you release updates, you will need to deal with migrating
#     data from previous schema versions to new ones, since users should not have
#     to think about such things.
#   * Launching other daemons your app needs (e.g. mysqld, redis-server, etc.)

# By default, this script does nothing.  You'll have to modify it as
# appropriate for your application.

# python devs don't know bash
export PS1=''
source env/bin/activate

ls -la env/bin
ls -la /home/abliss/
ls -la /home/abliss/proj
ls -la /home/abliss/proj/sandstorm
ls -la /home/abliss/proj/sandstorm/matrix
ls -la /home/abliss/proj/sandstorm/matrix/env
ls -la /home/abliss/proj/sandstorm/matrix/env/bin

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
export HOME=/var
synctl start --no-daemonize
