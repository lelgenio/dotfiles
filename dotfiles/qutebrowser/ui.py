#!/bin/env python
# {{@@ header() @@}}

from qutebrowser.config.configfiles import ConfigAPI   # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

# {%@@ if False @@%}
config = ConfigAPI()
c = ConfigContainer()
# {%@@ endif @@%}


#################################################
# Hints
#################################################

c.hints.border = "2px solid {{@@ accent_color @@}}"

#################################################
# Scrolling
#################################################

c.scrolling.bar = 'overlay'
c.scrolling.smooth = True

#################################################
# Tabs
#################################################

c.tabs.show = "multiple"

c.tabs.favicons.show = "always"
c.tabs.title.format = "{audio} {current_title}"
c.tabs.indicator.width = 0
c.tabs.padding = {
    'top': 3,
    'bottom': 3,
    'left': 5,
    'right': 5,
}

c.tabs.select_on_remove = "last-used"
c.tabs.show_switching_delay = 2000

#################################################
# Statusbar
#################################################

c.statusbar.show = "always"
c.completion.shrink = True
c.statusbar.widgets = ["keypress", "url", "scroll", "history", "tabs"]
