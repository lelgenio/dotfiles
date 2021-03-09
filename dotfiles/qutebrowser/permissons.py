#!/bin/env python
# {{@@ header() @@}}

from qutebrowser.config.configfiles import ConfigAPI   # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

from qutebrowser.api import interceptor  # type: ignore

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
    Safari/{webkit_version}
    """.replace("\n", "").replace("\t", " ")


# STFU
config.set("content.notifications", False, "*")
config.set('content.register_protocol_handler', False, '*')

###############################################################
# Single website settings
###############################################################

# Allow websites to request geolocations.
config.set("content.geolocation", True, "https://openweathermap.org")

# Allow websites to record audio/video.
bb_url = "https://*.bbcollab.com"
config.set("content.media.audio_video_capture", True, bb_url)
config.set("content.autoplay", True, bb_url)
config.set("content.mute", False, bb_url)


# Youtube
@interceptor.register
def filter_yt(info: interceptor.Request):
    url = info.request_url
    if (
            url.host() == "www.youtube.com"
            and url.path() == "/get_video_info"
            and "&adformat=" in url.query()
    ):
        info.block()


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
