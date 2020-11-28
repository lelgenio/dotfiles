#!/bin/env python
# {{@@ header() @@}}

from qutebrowser.config.configfiles import ConfigAPI   # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

# {%@@ if False @@%}
config = ConfigAPI()
c = ConfigContainer()
# {%@@ endif @@%}


###############################################################
# Global
###############################################################

c.content.mute = True
c.content.autoplay = False

c.content.headers.user_agent = """\
    Mozilla/5.0 ({os_info})
    AppleWebKit/{webkit_version} (KHTML, like Gecko)
    {qt_key}/{qt_version}
    {upstream_browser_key}/{upstream_browser_version}
    Safari/{webkit_version}""".replace("\n", "")


# STFU
config.set("content.notifications", False, "*")
config.set('content.register_protocol_handler', False, '*')

###############################################################
# Single website settings
###############################################################

# Allow websites to request geolocations.
config.set("content.geolocation", True, "https://openweathermap.org")

# Allow websites to record audio/video.
# config.set("content.media_capture", True, "https://ca.bbcollab.com")
config.set("content.media.audio_video_capture", True,
           "https://ca.bbcollab.com")
config.set("content.autoplay", True, "https://ca.bbcollab.com")
config.set("content.mute", False, "https://ca.bbcollab.com")


###############################################################
# Internals
###############################################################

# Enable JavaScript.
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

config.set("content.cookies.accept", "all", "chrome-devtools://*")

config.set("content.cookies.accept", "all", "devtools://*")
