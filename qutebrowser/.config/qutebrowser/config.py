# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'q': 'close', 'qa': 'quit', 'w': 'session-save', 'wq': 'quit --save', 'wqa': 'quit --save'}

# User agent to send. Unset to send the default. Note that the value
# read from JavaScript is always the global value.
# Type: String
c.content.headers.user_agent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36'

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications', False, 'https://www.1337x.to')

# Shrink the completion to be smaller than the configured size if there
# are no scrollbars.
# Type: Bool
c.completion.shrink = True

# CSS border value for hints.
# Type: String
c.hints.border = '2px solid #cc5757'

# Hide the statusbar unless a message is shown.
# Type: Bool
c.statusbar.hide = True

# When to show favicons in the tab bar.
# Type: String
# Valid values:
#   - always: Always show favicons.
#   - never: Always hide favicons.
#   - pinned: Show favicons only on pinned tabs.
c.tabs.favicons.show = 'never'

# How to behave when the last tab is closed.
# Type: String
# Valid values:
#   - ignore: Don't do anything.
#   - blank: Load a blank page.
#   - startpage: Load the start page.
#   - default-page: Load the default page.
#   - close: Close the window.
c.tabs.last_close = 'close'

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
c.tabs.title.format = '{current_title}'

# Width (in pixels) of the progress indicator (0 to disable).
# Type: Int
c.tabs.indicator.width = 0

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
c.colors.completion.item.selected.bg = '#cc5757'

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

# Font color for hints.
# Type: QssColor
c.colors.hints.fg = 'white'

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
# Type: QssColor
c.colors.hints.bg = '#303030'

# Font color for the matched part of hints.
# Type: QtColor
c.colors.hints.match.fg = '#cc5757'

# Highlight color for keys to complete the current keychain.
# Type: QssColor
c.colors.keyhint.suffix.fg = '#cc5757'

# Background color of the keyhint widget.
# Type: QssColor
c.colors.keyhint.bg = 'rgba(30, 30, 30, 95%)'

# Background color of the statusbar.
# Type: QssColor
c.colors.statusbar.normal.bg = '#202020'

# Background color of the statusbar in command mode.
# Type: QssColor
c.colors.statusbar.command.bg = '#202020'

# Background color of the statusbar in caret mode with a selection.
# Type: QssColor
c.colors.statusbar.caret.selection.bg = '#cc5757'

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
c.colors.tabs.selected.odd.bg = '#cc5757'

# Foreground color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.fg = 'white'

# Background color of selected even tabs.
# Type: QtColor
c.colors.tabs.selected.even.bg = '#cc5757'

# Background color of pinned selected odd tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.odd.bg = '#303030'

# Background color of pinned selected even tabs.
# Type: QtColor
c.colors.tabs.pinned.selected.even.bg = '#303030'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '16px Roboto'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = '16px FiraCode'

# Font used for the debugging console.
# Type: QtFont
c.fonts.debug_console = '16px FiraCode'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '16px FiraCode'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 16px FiraCode'

# Font used in the keyhint widget.
# Type: Font
c.fonts.keyhint = '16px FiraCode'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '16px FiraCode'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '16px FiraCode'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '16px FiraCode'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '16px Roboto'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '16px FiraCode'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '14px Roboto'

# Bindings for normal mode
config.bind(',m', 'spawn mpv {url}')
config.bind(';m', 'hint url spawn mpv {url}')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('j', 'scroll down')
config.bind('k', 'scroll up')
