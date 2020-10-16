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
    Safari/{webkit_version}""".replace("\n","")

# Enable JavaScript.
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow websites to record audio/video.
# config.set("content.media_capture", True, "https://ca.bbcollab.com")
config.set("content.media.audio_video_capture", True, "https://ca.bbcollab.com")
config.set("content.autoplay", True, "https://ca.bbcollab.com")
config.set("content.mute", False, "https://ca.bbcollab.com")

# Allow websites to show notifications.
config.set("content.notifications", False, "*")

# Allow websites to register protocol handlers via
config.set('content.register_protocol_handler', False,
           'https://mail.disroot.org?mailto&to=%25s')

c.content.mute = True
c.content.autoplay = False
# }}}
# UI {{{
# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = True

# CSS border value for hints.
# Type: String
c.hints.border = "2px solid {{@@ color.accent @@}}"

# Characters used for hint strings.
# {%@@ if key.layout == "colemak" @@%} #
c.hints.chars = "asrtdhneio"
# {%@@ elif key.layout == "dvorak" @@%} #
c.hints.chars = "aoeuidnths"
# {%@@ endif @@%}

# c.input.insert_mode.auto_leave = False

# necessary for screensharing due to bug
c.scrolling.bar = 'never'

c.scrolling.smooth = True

c.statusbar.widgets = ["keypress", "url", "scroll", "history", "tabs"]

c.tabs.favicons.show = "always"
c.tabs.select_on_remove = "last-used"

# When to show the status/tab bar.
c.tabs.show = "switching"
c.statusbar.show = "in-mode"

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

c.colors.completion.category.fg = "{{@@ color.txt @@}}"
c.colors.completion.category.bg = "{{@@ color.bg_dark @@}}"
c.colors.completion.category.border.top = "{{@@ color.bg_dark @@}}"
c.colors.completion.category.border.bottom = "{{@@ color.bg_dark @@}}"

c.colors.completion.item.selected.bg = "{{@@ color.accent @@}}"
c.colors.completion.item.selected.border.top = "{{@@ color.bg_dark @@}}"
c.colors.completion.item.selected.border.bottom = "{{@@ color.bg_dark @@}}"

c.colors.completion.fg = "{{@@ color.txt @@}}"
c.colors.completion.even.bg = "{{@@ color.bg_light @@}}"
c.colors.completion.odd.bg = "{{@@ color.bg @@}}"

c.colors.statusbar.command.fg = "{{@@ color.txt @@}}"

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = "{{@@ color.txt @@}}"

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = "{{@@ color.bg_light @@}}"

# Background color for the download bar.
c.colors.downloads.bar.bg = "{{@@ color.bg @@}}"

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = "{{@@ color.normal.blue @@}}"

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = "{{@@ color.normal.green @@}}"

# Font color for hints.
c.colors.hints.fg = "{{@@ color.txt @@}}"

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = "{{@@ color.bg @@}}"

# Font color for the matched part of hints.
c.colors.hints.match.fg = "{{@@ color.accent @@}}"

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = "{{@@ color.accent @@}}"

# Background color of the keyhint widget.
c.colors.keyhint.bg = "rgba(30, 30, 30, 95%)"

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = "{{@@ color.txt @@}}"

# Background color of the statusbar.
c.colors.statusbar.normal.bg = "{{@@ color.bg @@}}"

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = "{{@@ color.normal.green @@}}"

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = "{{@@ color.bg @@}}"

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = "{{@@ color.bg @@}}"

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = "{{@@ color.accent @@}}"

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = "{{@@ color.txt @@}}"

# Background color of the tab bar.
c.colors.tabs.bar.bg = "{{@@ color.bg @@}}"

# Foreground color of tabs.
c.colors.tabs.even.fg = "{{@@ color.txt @@}}"
c.colors.tabs.odd.fg = "{{@@ color.txt @@}}"
# Background color of tabs.
c.colors.tabs.even.bg = "{{@@ color.bg @@}}"
c.colors.tabs.odd.bg = "{{@@ color.bg @@}}"

# Foreground color of selected tabs.
c.colors.tabs.selected.even.fg = "{{@@ color.txt @@}}"
c.colors.tabs.selected.odd.fg = "{{@@ color.txt @@}}"
# Background color of selected tabs.
c.colors.tabs.selected.even.bg = "{{@@ color.accent @@}}"
c.colors.tabs.selected.odd.bg = "{{@@ color.accent @@}}"

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = "{{@@ color.bg_light @@}}"

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = "{{@@ color.bg_light @@}}"

# {%@@ if color.type == "dark" @@%} #
c.colors.webpage.bg = "{{@@ color.bg @@}}"
c.colors.webpage.prefers_color_scheme_dark = True
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.threshold.background = 256 // 2
c.colors.webpage.darkmode.threshold.text = 256 // 2
# {%@@ endif @@%}
# }}}
# Fonts {{{
# Font used in the completion widget.
c.fonts.completion.entry = "16px {{@@ font.interface @@}}"

# Font used in the completion categories.
c.fonts.completion.category = "16px {{@@ font.mono @@}}"

# Font used for the debugging console.
c.fonts.debug_console = "16px {{@@ font.mono @@}}"

# Font used for the downloadbar.
c.fonts.downloads = "16px {{@@ font.mono @@}}"

# Font used for the hints.
c.fonts.hints = "bold 16px {{@@ font.mono @@}}"

# Font used in the keyhint widget.
c.fonts.keyhint = "16px {{@@ font.mono @@}}"

# Font used for error messages.
c.fonts.messages.error = "16px {{@@ font.mono @@}}"

# Font used for info messages.
c.fonts.messages.info = "16px {{@@ font.mono @@}}"

# Font used for warning messages.
c.fonts.messages.warning = "16px {{@@ font.mono @@}}"

# Font used for prompts.
c.fonts.prompts = "16px {{@@ font.interface @@}}"

# Font used in the statusbar.
c.fonts.statusbar = "14px {{@@ font.mono @@}}"

# Font used in the tab bar.
c.fonts.tabs.selected = "14px {{@@ font.interface @@}}"
c.fonts.tabs.unselected = "14px {{@@ font.interface @@}}"
# }}}
# Bindings {{{
# Bindings for normal mode
config.bind(",d", "spawn --verbose youtube-dl {url}")
config.bind(",m", "spawn mpv --fs {url}")
config.bind(",r", "spawn --userscript readability")
config.bind(";e", "hint links spawn deemix '{hint-url}'")
config.bind(";m", "hint links spawn mpv --fs {hint-url}")

# {%@@ if key.layout == "colemak" @@%} #
config.bind("t", "hint all")
config.bind("T", "hint all tab")

config.bind("h", "set-cmd-text -s :open")
config.bind("H", "set-cmd-text -s :open -t")

# {%@@ endif @@%}

config.bind("{{@@ key.insertMode    @@}}", "enter-mode insert")
# config.bind("{{@@ key.insertQuit    @@}}", "enter-mode normal", mode="insert")

config.bind("{{@@ key.next          @@}}", "search-next")
config.bind("{{@@ key.next.upper()  @@}}", "search-prev")

config.bind("{{@@ key.left  @@}}", "scroll left")
config.bind("{{@@ key.down  @@}}", "scroll down")
config.bind("{{@@ key.up    @@}}", "scroll up")
config.bind("{{@@ key.right @@}}", "scroll right")

config.bind("{{@@ key.left  .upper() @@}}", "back")
config.bind("{{@@ key.right .upper() @@}}", "forward")

config.bind("{{@@ key.up    .upper() @@}}", "scroll-px 0 -100")
config.bind("{{@@ key.down  .upper() @@}}", "scroll-px 0  100")

config.bind("{{@@ key.tabL  .upper() @@}}", "tab-prev")
config.bind("{{@@ key.tabR  .upper() @@}}", "tab-next")

# Bindings for caret mode
config.bind("{{@@ key.left  @@}}", "move-to-prev-char", mode="caret")
config.bind("{{@@ key.up    @@}}", "move-to-prev-line", mode="caret")
config.bind("{{@@ key.down  @@}}", "move-to-next-line", mode="caret")
config.bind("{{@@ key.right @@}}", "move-to-next-char", mode="caret")

# Bindings for insert mode
config.bind(
    "<Ctrl+i>",
    "spawn --userscript qute-keepass -p ~/Documentos/senhas/Senhas.kdbx",
    mode="insert",
)

c.editor.command = ["terminal", "nvim", "-f", "{file}", "+{line}"]
# }}}

# vim: fdm=marker
