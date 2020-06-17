# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'q': 'close', 'qa': 'quit', 'w': 'session-save', 'wq': 'quit --save', 'wqa': 'quit --save', 'cw': 'config-write-py -f'}

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = True

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')

# Which cookies to accept. With QtWebEngine, this setting also controls
# other features with tracking capabilities similar to those of cookies;
# including IndexedDB, DOM storage, filesystem API, service workers, and
# AppCache. Note that with QtWebKit, only `all` and `never` are
# supported as per-domain values. Setting `no-3rdparty` or `no-
# unknown-3rdparty` per-domain on QtWebKit will have the same effect as
# `all`.
# Type: String
# Valid values:
#   - all: Accept all cookies.
#   - no-3rdparty: Accept cookies from the same origin only. This is known to break some sites, such as GMail.
#   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain. On QtWebEngine, this is the same as no-3rdparty.
#   - never: Don't accept cookies at all.
config.set('content.cookies.accept', 'all', 'devtools://*')

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
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36'

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
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

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
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')

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
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')

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
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')

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
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to record audio/video.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.media_capture', True, 'https://ca.bbcollab.com')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', False, 'https://www.1337x.to')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', True, 'https://www.reddit.com')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', True, 'https://dev.lemmy.ml')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', False, 'https://www.duolingo.com')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', False, 'https://www.jornalcontabil.com.br')

# Proxy to use. In addition to the listed values, you can use a
# `socks://...` or `http://...` URL.
# Type: Proxy
# Valid values:
#   - system: Use the system wide proxy.
#   - none: Don't use any proxy
c.content.proxy = 'system'

# Automatically mute tabs. Note that if the `:tab-mute` command is used,
# the mute status for the affected tab is now controlled manually, and
# this setting doesn't have any effect.
# Type: Bool
c.content.mute = True

# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = True

# CSS border value for hints.
# Type: String
c.hints.border = '2px solid #D9534F'

# Characters used for hint strings.
# Type: UniqueCharString
c.hints.chars = 'aoeuidnths'

# Leave insert mode if a non-editable element is clicked.
# Type: Bool
c.input.insert_mode.auto_leave = False

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = True

# Hide the statusbar unless a message is shown.
# Type: Bool
c.statusbar.hide = False

# Position of the status bar.
# Type: VerticalPosition
# Valid values:
#   - top
#   - bottom
c.statusbar.position = 'top'

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
c.statusbar.widgets = ['keypress', 'url', 'scroll', 'history', 'tabs']

# Open new tabs (middleclick/ctrl+click) in the background.
# Type: Bool
c.tabs.background = False

# When to show favicons in the tab bar.
# Type: String
# Valid values:
#   - always: Always show favicons.
#   - never: Always hide favicons.
#   - pinned: Show favicons only on pinned tabs.
c.tabs.favicons.show = 'always'

# How to behave when the last tab is closed.
# Type: String
# Valid values:
#   - ignore: Don't do anything.
#   - blank: Load a blank page.
#   - startpage: Load the start page.
#   - default-page: Load the default page.
#   - close: Close the window.
c.tabs.last_close = 'startpage'

# Which tab to select when the focused tab is removed.
# Type: SelectOnRemove
# Valid values:
#   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
#   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
#   - last-used: Select the previously selected tab.
c.tabs.select_on_remove = 'last-used'

# When to show the tab bar.
# Type: String
# Valid values:
#   - always: Always show the tab bar.
#   - never: Always hide the tab bar.
#   - multiple: Hide the tab bar if only one tab is open.
#   - switching: Show the tab bar when switching tabs.
c.tabs.show = 'multiple'

# Duration (in milliseconds) to show the tab bar before hiding it when
# tabs.show is set to 'switching'.
# Type: Int
c.tabs.show_switching_delay = 2000

# Format to use for the tab title. The following placeholders are
# defined:  * `{perc}`: Percentage as a string like `[10%]`. *
# `{perc_raw}`: Raw percentage, e.g. `10`. * `{current_title}`: Title of
# the current web page. * `{title_sep}`: The string ` - ` if a title is
# set, empty otherwise. * `{index}`: Index of this tab. * `{id}`:
# Internal tab ID of this tab. * `{scroll_pos}`: Page scroll position. *
# `{host}`: Host of the current web page. * `{backend}`: Either
# ''webkit'' or ''webengine'' * `{private}`: Indicates when private mode
# is enabled. * `{current_url}`: URL of the current web page. *
# `{protocol}`: Protocol (http/https/...) of the current web page. *
# `{audio}`: Indicator for audio/mute status.
# Type: FormatString
c.tabs.title.format = '{audio}{index}: {current_title}'

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

# Page to open if :open -t/-b/-w is used without URL. Use `about:blank`
# for a blank page.
# Type: FuzzyUrl
c.url.default_page = 'https://search.disroot.org'

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
c.url.searchengines = {'DEFAULT': 'search.disroot.org?q={}', '!aw': 'wiki.archlinux.org?search={}', '!w': 'pt.wikipedia.org/w?search={}'}

# Page(s) to open at the start.
# Type: List of FuzzyUrl, or FuzzyUrl
c.url.start_pages = 'https://search.disroot.org'

# Background color of the completion widget for odd rows.
# Type: QssColor
c.colors.completion.odd.bg = '#202020'

# Background color of the completion widget for even rows.
# Type: QssColor
c.colors.completion.even.bg = '#303030'

# Background color of the completion widget category headers.
# Type: QssColor
c.colors.completion.category.bg = '#303030'

# Background color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.bg = '#D9534F'

# Top border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.top = '#550000'

# Bottom border color of the selected completion item.
# Type: QssColor
c.colors.completion.item.selected.border.bottom = '#550000'

# Foreground color of the matched text in the selected completion item.
# Type: QtColor
c.colors.completion.item.selected.match.fg = 'white'

# Color of the scrollbar in the completion view.
# Type: QssColor
c.colors.completion.scrollbar.bg = '#303030'

# Background color for the download bar.
# Type: QssColor
c.colors.downloads.bar.bg = '#202020'

# Color gradient start for download backgrounds.
# Type: QtColor
c.colors.downloads.start.bg = '#5757cc'

# Color gradient stop for download backgrounds.
# Type: QtColor
c.colors.downloads.stop.bg = '#57cc57'

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = 'white'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#303030'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#D9534F'

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = '#D9534F'

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = 'rgba(30, 30, 30, 95%)'

# Foreground color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.fg = 'gray'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#202020'

# Foreground color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.fg = '#aaffaa'

# Background color of the statusbar in insert mode.
# Type: QssColor
c.colors.statusbar.insert.bg = '#202020'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#202020'

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = '#D9534F'

# Foreground color of the URL in the statusbar on successful load
# (https).
# Type: QssColor
c.colors.statusbar.url.success.https.fg = 'white'

# Background color of the tab bar.
# Type: QssColor
c.colors.tabs.bar.bg = '#202020'

# Background color of unselected odd tabs.
# Type: QtColor
c.colors.tabs.odd.bg = '#202020'

# Background color of unselected even tabs.
# Type: QtColor
c.colors.tabs.even.bg = '#202020'

# Foreground color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.fg = 'white'

# Background color of selected odd tabs.
# Type: QtColor
c.colors.tabs.selected.odd.bg = '#D9534F'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = 'white'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#D9534F'

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = '#303030'

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = '#303030'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '16px Inter'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = '16px Hack'

# Font used for the debugging console.
# Type: QtFont
c.fonts.debug_console = '16px Hack'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '16px Hack'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 16px Hack'

# Font used in the keyhint widget.
# Type: Font
c.fonts.keyhint = '16px Hack'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '16px Hack'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '16px Hack'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '16px Hack'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '16px Inter'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '14px Hack'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '14px Inter'

# Bindings for normal mode
config.bind(',m', 'spawn --userscript view_in_mpv')
config.bind(',r', 'spawn --userscript readability')
config.bind(';e', "hint links spawn deemix '{hint-url}'")
config.bind(';m', 'hint links spawn mpv --fs {hint-url}')
config.bind('E', 'hint all tab')
config.bind('H', 'back')
config.bind('L', 'search-prev')
config.bind('N', 'tab-next')
config.bind('S', 'forward')
config.bind('T', 'tab-prev')
config.bind('e', 'hint all')
config.bind('h', 'scroll left')
config.bind('l', 'search-next')
config.bind('n', 'scroll up')
config.bind('s', 'scroll right')
config.bind('t', 'scroll down')

# Bindings for insert mode
config.bind('<Ctrl+i>', 'spawn --userscript qute-keepass -p ~/Documentos/senhas/Senhas.kdbx', mode='insert')
