

import logging
from twisted.internet import defer
import requests
import json
from synapse.util.async_helpers import Linearizer

logger = logging.getLogger(__name__)
from trepan.api import debug
from trepan.interfaces import server as Mserver
#debug(dbg_opts={'interface':Mserver.ServerInterface(connection_opts={'IO':'FIFO'})})
import signal
def signal_handler(num, f):
  logger.info("Caught sig handler.")
  from trepan.api import debug;
  debug(dbg_opts={'interface':Mserver.ServerInterface(connection_opts={'IO':'FIFO'})})
  return
signal.signal(signal.SIGUSR1, signal_handler)

def signal_handler2(num, f):
  logger.info("Caught sig handler 2.")
  import importlib
  importlib.reload(importlib.import_module("matrix_sandstorm_auth_provider"))
  return

signal.signal(signal.SIGUSR2, signal_handler2)

def getHeader(headers, key, default):
    raw = headers.getRawHeaders(key)
    if raw:
      return raw[0]
    else:
      return default

class Provider(object):
    def __init__(self, config, account_handler):
        self._account_handler = account_handler
        logger.info("XXXX Log?!")
        print("YYYY Printing")
        # identifier for the external_ids table
        self._auth_provider_id = "sandstorm"
        # a lock on the mappings
        self._mapping_lock = Linearizer(name="sandstorm_mapping")

    @staticmethod
    def parse_config(config):
        pass

    def get_supported_login_types(self):
        logger.info("XXXX Get supported?!")
        print("YYYY Printing")
        return {
            #"m.login.dummy":(),
            #"m.login.cas":(),
            "io.sandstorm":(u"headers",),
            #"m.login.password":(),
        }
    @defer.inlineCallbacks
    def check_auth(self, username, login_type, login_dict):
        logger.info("XXXX Got auth check for " + username + ": " + login_type + " : " + str(login_dict))
        headers = login_dict["headers"]
        display_name = getHeader(headers,"X-Sandstorm-Username", "UnknownName")
        external_id = getHeader(headers,"X-Sandstorm-User-Id", "GuestId")
        perms = getHeader(headers,"X-Sandstorm-Permissions", "")
        handle = getHeader(headers,"X-Sandstorm-Preferred-Handle", "UnknownHandle")
        pic = getHeader(headers,"X-Sandstorm-User-Picture", "")
        pronouns = getHeader(headers,"X-Sandstorm-User-Pronouns", "")
        with (yield self._mapping_lock.queue(self._auth_provider_id)):
            try: 
                registered_user_id = yield self._account_handler.get_user_by_external_id(
                    self._auth_provider_id, external_id)
                # XXX WTF
                registered_user_id = yield defer.ensureDeferred(registered_user_id)
            except e:
                log.warning("Could not get external id: ", e)
            if registered_user_id is not None:
                logger.info("Found existing mapping %s!!", registered_user_id)
                defer.returnValue(registered_user_id)
               
            else:
                logger.info("User %s does not exist yet, creating...", handle)
                for suffix in [""] + ["_" + str(x) for x in range(1000)]:
                    localpart = handle + suffix
                    mxid = self._account_handler.get_qualified_user_id(localpart)
                    exists = yield self._account_handler.check_user_exists(mxid)
                    if exists:
                        logger.info("Handle conflicts with %s, trying again", exists)
                    else:
                        logger.info("Registering user %s as %s", external_id, mxid)
                        registered, access_token = (yield self._account_handler.register(
                          localpart=localpart, displayname=display_name
                        ))
                        logger.info("Registration was successful as %s; recording mapping", registered) 
                        result = yield self._account_handler.record_user_external_id(
                            self._auth_provider_id, external_id, registered
                        )
                        logger.info("Mapping successful: %s", result) 
                        defer.returnValue(registered)
        logger.warning("Could not register user %s!", external_id)
        defer.returnValue(None)

