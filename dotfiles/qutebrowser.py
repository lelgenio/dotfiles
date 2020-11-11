#!/bin/env python
# {{@@ header() @@}}

# Ignore import error
# pylint: disable=E0401,E0602
# type: ignore
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

config = config
c = c
# Ignore undefined
config: ConfigAPI
c: ConfigContainer

# Behavior {{{

c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
}

# Load a restored tab as soon as it takes focus.
c.session.lazy_restore = True

# Enable screensharing for wayland
c.qt.args = ['enable-features=WebRTCPipeWireCapturer']

# Always restore open sites when qutebrowser is reopened.
c.auto_save.session = True

config.set("content.cookies.accept", "all", "chrome-devtools://*")

config.set("content.cookies.accept", "all", "devtools://*")

# Allow websites to request geolocations.
config.set("content.geolocation", True, "https://openweathermap.org")

c.content.headers.user_agent = """\
    Mozilla/5.0 ({os_info})
    AppleWebKit/{webkit_version} (KHTML, like Gecko)
    {qt_key}/{qt_version}
    {upstream_browser_key}/{upstream_browser_version}
    Safari/{webkit_version}""".replace("\n", "")

# Enable JavaScript.
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow websites to record audio/video.
# config.set("content.media_capture", True, "https://ca.bbcollab.com")
config.set("content.media.audio_video_capture", True,
           "https://ca.bbcollab.com")
config.set("content.autoplay", True, "https://ca.bbcollab.com")
config.set("content.mute", False, "https://ca.bbcollab.com")

# Allow websites to show notifications.
config.set("content.notifications", False, "*")

# Allow websites to register protocol handlers via
config.set('content.register_protocol_handler', False,
           'https://mail.disroot.org?mailto&to=%25s')

c.content.mute = True
c.content.autoplay = False

editor = "{{@@ editor @@}}"
c.editor.command = ["terminal", editor, "{file}", "+{line}"]

# }}}
# UI {{{
# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = True

# CSS border value for hints.
# Type: String
c.hints.border = "2px solid {{@@ accent_color @@}}"

# Characters used for hint strings.
# {%@@ if key_layout == "colemak" @@%} #
c.hints.chars = "asrtdhneio"
# {%@@ elif key_layout == "dvorak" @@%} #
c.hints.chars = "aoeuidnths"
# {%@@ endif @@%}

# c.input.insert_mode.auto_leave = False

# Scrollbar style
c.scrolling.bar = 'overlay'

c.scrolling.smooth = True

c.statusbar.widgets = ["keypress", "url", "scroll", "history", "tabs"]

c.tabs.favicons.show = "always"
c.tabs.select_on_remove = "last-used"

# When to show the status/tab bar.
c.tabs.show = "always"
c.statusbar.show = "always"

c.tabs.show_switching_delay = 2000
c.tabs.title.format = "{audio} {current_title}"
c.tabs.indicator.width = 0
# }}}
# Search {{{

# {%@@ set search_engine = "start.duckduckgo.com" @@%} #


c.url.default_page = "{{@@ search_engine @@}}"

c.url.searchengines = {
    "DEFAULT": "{{@@ search_engine @@}}?q={}",
    "!aw": "wiki.archlinux.org?search={}",
    "!w": "wikipedia.org/w?search={}",
    "!wpt": "pt.wikipedia.org/w?search={}",
    "!au": "aur.archlinux.org/packages/?K={}",
    "!alt": "alternativeto.net/browse/search?q={}",
    "!gw": "wiki.gentoo.org/?search={}",
    "!yt": "youtube.com/results?q={}",
}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = "{{@@ search_engine @@}}"
# }}}
# Colors {{{


class color:
    accent = "{{@@ accent_color @@}}"
    txt = "{{@@ color.txt @@}}"
    bg = "{{@@ color.bg @@}}"
    bg_dark = "{{@@ color.bg_dark @@}}"
    bg_light = "{{@@ color.bg_light @@}}"


c.colors.completion.category.fg = color.txt
c.colors.completion.category.bg = color.bg_light
c.colors.completion.category.border.top = color.bg_dark
c.colors.completion.category.border.bottom = color.bg_dark

c.colors.completion.item.selected.fg = color.txt
c.colors.completion.item.selected.bg = color.accent
c.colors.completion.item.selected.border.top = color.bg_dark
c.colors.completion.item.selected.border.bottom = color.bg_dark

c.colors.completion.fg = color.txt
c.colors.completion.even.bg = color.bg
c.colors.completion.odd.bg = color.bg
c.colors.completion.item.selected.match.fg = color.txt
c.colors.completion.scrollbar.bg = color.bg_light


c.colors.downloads.bar.bg = color.bg
c.colors.downloads.start.bg = "{{@@ color.normal.blue @@}}"
c.colors.downloads.stop.bg = "{{@@ color.normal.green @@}}"


c.colors.hints.fg = color.txt
c.colors.hints.bg = color.bg
c.colors.hints.match.fg = color.accent


c.colors.keyhint.suffix.fg = color.accent
c.colors.keyhint.fg = color.txt
c.colors.keyhint.bg = "rgba({{@@ hex2rgb(color.bg) @@}}, {{@@ opacity @@}})"


c.colors.statusbar.normal.fg = color.txt
c.colors.statusbar.normal.bg = color.bg
c.colors.statusbar.insert.bg = color.bg
c.colors.statusbar.command.fg = color.txt
c.colors.statusbar.command.bg = color.bg
c.colors.statusbar.caret.selection.bg = color.accent
c.colors.statusbar.url.success.https.fg = color.txt
c.colors.statusbar.url.success.http.fg = "{{@@ color.normal.yellow @@}}"
c.colors.statusbar.url.hover.fg = "{{@@ color.normal.cyan @@}}"
c.colors.statusbar.insert.fg = "{{@@ color.normal.green @@}}"


c.colors.tabs.bar.bg = color.bg
c.colors.tabs.even.fg = color.txt
c.colors.tabs.odd.fg = color.txt
c.colors.tabs.even.bg = color.bg
c.colors.tabs.odd.bg = color.bg

c.colors.tabs.selected.even.fg = color.bg
c.colors.tabs.selected.odd.fg = color.bg
c.colors.tabs.selected.even.bg = color.accent
c.colors.tabs.selected.odd.bg = color.accent

c.colors.tabs.pinned.selected.odd.bg = color.accent
c.colors.tabs.pinned.selected.even.bg = color.accent


c.colors.contextmenu.menu.bg = color.bg
c.colors.contextmenu.menu.fg = color.txt
c.colors.contextmenu.selected.bg = color.accent
c.colors.contextmenu.disabled.fg = color.bg_light


# {%@@ if color.type == "dark" @@%} #
c.colors.webpage.bg = color.bg
c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.threshold.background = 256 // 2
c.colors.webpage.darkmode.threshold.text = 256 // 2
# {%@@ endif @@%}


# }}}
# Fonts {{{

class fonts:
    DEF_MONO = "{{@@ font.size.medium @@}}px {{@@ font.mono @@}}"
    BIG_MONO = "{{@@ font.size.big @@}}px {{@@ font.mono @@}}"
    DEF_INTER = "{{@@ font.size.medium @@}}px {{@@ font.interface @@}}"
    BIG_INTER = "{{@@ font.size.big @@}}px {{@@ font.interface @@}}"


c.fonts.completion.entry = fonts.BIG_INTER

c.fonts.completion.category = fonts.BIG_INTER
c.fonts.debug_console = fonts.BIG_INTER
c.fonts.hints = 'bold ' + fonts.BIG_MONO
c.fonts.keyhint = fonts.BIG_INTER

c.fonts.messages.error = fonts.BIG_INTER
c.fonts.messages.info = fonts.BIG_INTER
c.fonts.messages.warning = fonts.BIG_INTER

c.fonts.statusbar = fonts.DEF_MONO

c.fonts.tabs.selected = fonts.DEF_INTER
c.fonts.tabs.unselected = fonts.DEF_INTER

c.fonts.prompts = fonts.BIG_INTER
c.fonts.downloads = fonts.BIG_INTER

# }}}
# Bindings {{{
# Bindings for normal mode


class key:
    up = "{{@@ key.up @@}}"
    down = "{{@@ key.down @@}}"
    left = "{{@@ key.left @@}}"
    right = "{{@@ key.right @@}}"

    tabL = "{{@@ key.tabL @@}}"
    tabR = "{{@@ key.tabR @@}}"

    insert = "{{@@ key.insertMode @@}}"
    next = "{{@@ key.next @@}}"


config.bind(",d", "spawn --verbose youtube-dl -fbest[ext=mp4] {url}")
config.bind(",m", "spawn --userscript view_in_mpv")
config.bind(",r", "spawn --userscript readability")
config.bind(";e", "hint links spawn deemix '{hint-url}'")
config.bind(";m", "hint links spawn mpv --fs {hint-url}")

# {%@@ if key_layout == "colemak" @@%} #

config.bind("t", "hint all")
config.bind("h", "set-cmd-text -s :open")

for k, v in {
    "T": "hint all tab",
    "H": "set-cmd-text -s :open -t",
}.items():
    if editor == "kak":
        config.bind("<Alt-{}>".format(k), v)
    else:
        config.bind(k.upper(), v)

# {%@@ endif @@%}

config.bind(key.insert, "enter-mode insert")

config.bind(key.next, "search-next")
config.bind(key.next.upper(), "search-prev")


config.bind(key.left, "scroll left")
config.bind(key.down, "scroll down")
config.bind(key.up, "scroll up")
config.bind(key.right, "scroll right")

for k, v in {
    key.up: "scroll-px 0 -100",
    key.down: "scroll-px 0  100",
    key.left: "back",
    key.right: "forward",
    key.tabL: "tab-prev",
    key.tabR: "tab-next",
}.items():
    if editor == "kak":
        config.bind("<Alt-{}>".format(k), v)
    else:
        config.bind(k.upper(), v)

# Bindings for caret mode
config.bind(key.left, "move-to-prev-char", mode="caret")
config.bind(key.up, "move-to-prev-line", mode="caret")
config.bind(key.down, "move-to-next-line", mode="caret")
config.bind(key.right, "move-to-next-char", mode="caret")

# }}}

# vim: fdm=marker
