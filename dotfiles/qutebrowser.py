#!/bin/env python
# {{@@ header() @@}}

# Ignore import error
# pylint: disable=E0401
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

# Ignore undefined
config: ConfigAPI
c: ConfigContainer

# Behavior {{{

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {
    "q": "close",
    "qa": "quit",
    "w": "session-save",
    "wq": "quit --save",
    "wqa": "quit --save",
}

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = True

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

config.set("content.cookies.accept", "all", "chrome-devtools://*")

config.set("content.cookies.accept", "all", "devtools://*")

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.geolocation", True, "https://openweathermap.org")

# User agent to send.  The following placeholders are defined:  *
# `{os_info}`: Something like "X11; Linux x86_64". * `{webkit_version}`:
# The underlying WebKit version (set to a fixed value   with
# QtWebEngine). * `{qt_key}`: "Qt" for QtWebKit, "QtWebEngine" for
# QtWebEngine. * `{qt_version}`: The underlying Qt version. *
# `{upstream_browser_key}`: "Version" for QtWebKit, "Chrome" for
# QtWebEngine. * `{upstream_browser_version}`: The corresponding
# Safari/Chrome version. * `{qutebrowser_version}`: The currently
# running qutebrowser version.  The default value is equal to the
# unchanged user agent of QtWebKit/QtWebEngine.  Note that the value
# read from JavaScript is always the global value.
# Type: FormatString
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36 "

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}",
    "https://web.whatsapp.com/",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://accounts.google.com/*",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://docs.google.com/*",
)

config.set(
    "content.headers.user_agent",
    "Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0",
    "https://drive.google.com/*",
)

# Enable JavaScript.
# Type: Bool
config.set("content.javascript.enabled", True, "file://*")
config.set("content.javascript.enabled", True, "chrome-devtools://*")
config.set("content.javascript.enabled", True, "devtools://*")
config.set("content.javascript.enabled", True, "chrome://*/*")
config.set("content.javascript.enabled", True, "qute://*/*")

# Allow websites to record audio/video.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.media_capture", True, "https://ca.bbcollab.com")
config.set("content.autoplay", True, "https://ca.bbcollab.com")

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set("content.notifications", False, "*")

# Automatically mute tabs. Note that if the `:tab-mute` command is used,
# the mute status for the affected tab is now controlled manually, and
# this setting doesn't have any effect.
# Type: Bool
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
# Type: UniqueCharString
c.hints.chars = "aoeuidnths"

# Leave insert mode if a non-editable element is clicked.
# Type: Bool
c.input.insert_mode.auto_leave = False

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = True

# List of widgets displayed in the statusbar.
# Type: List of String
# Valid values:
#   - url: Current page URL.
#   - scroll: Percentage of the current page position like `10%`.
#   - scroll_raw: Raw percentage of the current page position like `10`.
#   - history: Display an arrow when possible to go back/forward in history.
#   - tabs: Current active tab, e.g. `2`.
#   - keypress: Display pressed keys when composing a vi command.
#   - progress: Progress bar for the current page loading.
c.statusbar.widgets = ["keypress", "url", "scroll", "history", "tabs"]

# When to show favicons in the tab bar.
# Type: String
# Valid values:
#   - always: Always show favicons.
#   - never: Always hide favicons.
#   - pinned: Show favicons only on pinned tabs.
c.tabs.favicons.show = "always"

# Which tab to select when the focused tab is removed.
# Type: SelectOnRemove
# Valid values:
#   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
#   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
#   - last-used: Select the previously selected tab.
c.tabs.select_on_remove = "last-used"

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = "multiple"

# Duration (in milliseconds) to show the tab bar before hiding it when
# tabs.show is set to 'switching'.
# Type: Int
c.tabs.show_switching_delay = 2000

# Format to use for the tab title. The following placeholders are
# defined:  * `{perc}`: Percentage as a string like `[10%]`. *
# `{perc_raw}`: Raw percentage, e.g. `10`. * `{current_title}`: Title of
# the current web page. * `{title_sep}`: The string ` - ` if a title is
# set, empty otherwise. * `{index}`: Index of this tab. * `{id}`:
# {{@@ font.interface @@}}nal tab ID of this tab. * `{scroll_pos}`: Page scroll position. *
# `{host}`: Host of the current web page. * `{backend}`: Either
# ''webkit'' or ''webengine'' * `{private}`: Indicates when private mode
# is enabled. * `{current_url}`: URL of the current web page. *
# `{protocol}`: Protocol (http/https/...) of the current web page. *
# `{audio}`: Indicator for audio/mute status.
# Type: FormatString
c.tabs.title.format = "{audio} {current_title}"

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0
# }}}
# Search {{{
# Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
# for a blank page.
# Type: FuzzyUrl
c.url.default_page = "https://search.disroot.org"

# Search engines which can be used via the address bar.  Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` braces.  The following further
# placeholds are defined to configure how special characters in the
# search terms are replaced by safe characters (called 'quoting'):  *
# `{}` and `{semiquoted}` quote everything except slashes; this is the
# most   sensible choice for almost all search engines (for the search
# term   `slash/and&amp` this placeholder expands to `slash/and%26amp`).
# * `{quoted}` quotes all characters (for `slash/and&amp` this
# placeholder   expands to `slash%2Fand%26amp`). * `{unquoted}` quotes
# nothing (for `slash/and&amp` this placeholder   expands to
# `slash/and&amp`).  The search engine named `DEFAULT` is used when
# `url.auto_search` is turned on and something else than a URL was
# entered to be opened. Other search engines can be used by prepending
# the search engine name to the search term, e.g. `:open google
# qutebrowser`.
# Type: Dict
c.url.searchengines = {
    "DEFAULT": "search.disroot.org?q={}",
    "!aw": "wiki.archlinux.org?search={}",
    "!w": "pt.wikipedia.org/w?search={}",
    "!au": "aur.archlinux.org/packages/?K={}",
}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = "https://search.disroot.org"
# }}}
# Colors {{{
# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = "{{@@ color.bg @@}}"
c.colors.completion.even.bg = "{{@@ color.bg_light @@}}"
c.colors.completion.category.bg = "{{@@ color.bg_dark @@}}"
c.colors.completion.item.selected.bg = "{{@@ color.accent @@}}"
c.colors.completion.item.selected.border.top = "#550000"
c.colors.completion.item.selected.border.bottom = "#550000"

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = "white"

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = "{{@@ color.bg_light @@}}"

# Background color for the download bar.
c.colors.downloads.bar.bg = "{{@@ color.bg @@}}"

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = "#5757cc"

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = "#57cc57"

# Font color for hints.
c.colors.hints.fg = "{{@@ color.txt @@}}"

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = "{{@@ color.bg_light @@}}"

# Font color for the matched part of hints.
c.colors.hints.match.fg = "{{@@ color.accent @@}}"

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = "{{@@ color.accent @@}}"

# Background color of the keyhint widget.
c.colors.keyhint.bg = "rgba(30, 30, 30, 95%)"

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = "gray"

# Background color of the statusbar.
c.colors.statusbar.normal.bg = "{{@@ color.bg @@}}"

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = "#aaffaa"

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = "{{@@ color.bg @@}}"

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = "{{@@ color.bg @@}}"

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = "{{@@ color.accent @@}}"

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = "white"

# Background color of the tab bar.
c.colors.tabs.bar.bg = "{{@@ color.bg @@}}"

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = "{{@@ color.bg @@}}"

# Background color of unselected even tabs.
c.colors.tabs.even.bg = "{{@@ color.bg @@}}"

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = "white"

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = "{{@@ color.accent @@}}"

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = "white"

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = "{{@@ color.accent @@}}"

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = "{{@@ color.bg_light @@}}"

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = "{{@@ color.bg_light @@}}"

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.threshold.background = 256 // 2
c.colors.webpage.darkmode.threshold.text = 256 // 2
c.colors.webpage.bg = "{{@@ color.bg @@}}"
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
c.fonts.tabs = "14px {{@@ font.interface @@}}"
# }}}
# Bindings {{{
# Bindings for normal mode
config.bind(",m", "spawn mpv --fs {url}")
config.bind(",r", "spawn --userscript readability")
config.bind(";e", "hint links spawn deemix '{hint-url}'")
config.bind(";m", "hint links spawn mpv --fs {hint-url}")

config.bind("e", "hint all")
config.bind("E", "hint all tab")

config.bind("{{@@ key.next         @@}}", "search-next")
config.bind("{{@@ key.next.upper() @@}}", "search-prev")

config.bind("{{@@ key.left  @@}}", "scroll left")
config.bind("{{@@ key.down  @@}}", "scroll down")
config.bind("{{@@ key.up    @@}}", "scroll up")
config.bind("{{@@ key.right @@}}", "scroll right")

config.bind("{{@@ key.left  .upper() @@}}", "back")
config.bind("{{@@ key.down  .upper() @@}}", "tab-prev")
config.bind("{{@@ key.up    .upper() @@}}", "tab-next")
config.bind("{{@@ key.right .upper() @@}}", "forward")

# Bindings for caret mode
config.bind("{{@@ key.left  @@}}", "move-to-prev-char", mode="caret")
config.bind("{{@@ key.down  @@}}", "move-to-prev-line", mode="caret")
config.bind("{{@@ key.up    @@}}", "move-to-next-line", mode="caret")
config.bind("{{@@ key.right @@}}", "move-to-next-char", mode="caret")

# Bindings for insert mode
config.bind(
    "<Ctrl+i>",
    "spawn --userscript qute-keepass -p ~/Documentos/senhas/Senhas.kdbx",
    mode="insert",
)

c.editor.command = ["terminal", "nvim", "-f", "{file}", "+{line}"]
# }}}
