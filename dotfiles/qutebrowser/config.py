#!/bin/env python
# {{@@ header() @@}}
#   ___        _       _
#  / _ \ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
# | | | | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
# | |_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#  \__\_\\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|


from source_yaml import source_yaml  # type: ignore

from qutebrowser.config.configfiles import ConfigAPI   # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

# {%@@ if False @@%}
config = ConfigAPI()
c = ConfigContainer()
# {%@@ endif @@%}

########################################################################
# Imports
########################################################################

source_yaml(config, "colors.yaml")
source_yaml(config, "fonts.yaml")
config.source("keys.py")
config.source("ui.py")
config.source("permissons.py")
c.content.user_stylesheets = "style.css"

########################################################################
# General options
########################################################################

# Load configurations from autoconfig.yaml
config.load_autoconfig(False)
# Load a restored tab as soon as it takes focus.
c.session.lazy_restore = True
# Always restore open sites when qutebrowser is reopened.
c.auto_save.session = True

# what command to run on [InsertMode]ctrl+e (default)
c.editor.command = ["terminal", "{{@@ editor @@}}", "{file}", "+{line}"]

########################################################################
# Search
########################################################################

search_engine = "start.duckduckgo.com"

c.url.default_page = search_engine
c.url.start_pages = search_engine
c.url.searchengines = {
    "DEFAULT": search_engine + "?q={}",
    "!aw": "wiki.archlinux.org?search={}",
    "!w": "wikipedia.org/w?search={}",
    "!wpt": "pt.wikipedia.org/w?search={}",
    "!au": "aur.archlinux.org/packages/?K={}",
    "!alt": "alternativeto.net/browse/search?q={}",
    "!gw": "wiki.gentoo.org/?search={}",
    "!yt": "youtube.com/results?q={}",
}
