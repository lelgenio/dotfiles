# {{@@ header() @@}}
#   ___        _       _
#  / _ \ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
# | | | | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
# | |_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
#  \__\_\\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|


from qutebrowser.config.configfiles import ConfigAPI   # type: ignore
from qutebrowser.config.config import ConfigContainer  # type: ignore

# {%@@ if False @@%}
config = ConfigAPI()
c = ConfigContainer()
# {%@@ endif @@%}


##########################################################
# Helpers
##########################################################

class key:
    "Object mapping of templated key bindings"
    up = "{{@@ key.up @@}}"
    down = "{{@@ key.down @@}}"
    left = "{{@@ key.left @@}}"
    right = "{{@@ key.right @@}}"

    tabL = "{{@@ key.tabL @@}}"
    tabR = "{{@@ key.tabR @@}}"

    insert = "{{@@ key.insertMode @@}}"
    next = "{{@@ key.next @@}}"


##########################################################
# Usermode
##########################################################

config.bind(",d", "spawn -o youtube-dl -fbest[ext=mp4] {url}")
config.bind(",r", "spawn --userscript readability")
config.bind(";e", "hint links spawn deemix '{hint-url}'")

mpvcom = "hint links spawn mpv --fs {hint-url} "
mpvusc = "spawn --userscript view_in_mpv"
mpvslowcom = " --ytdl-format='best[height<=360]'"

config.bind(";m", mpvcom)
config.bind(";M", mpvcom + mpvslowcom)
config.bind(",m", mpvusc)
config.bind(",M", mpvusc + mpvslowcom)


##########################################################
# Layout specific
##########################################################

c.hints.chars = "{{@@ key.hints @@}}"

key_layout = "{{@@ key_layout @@}}"
if key_layout == "colemak":
    config.bind("t", "hint all")
    config.bind("h", "set-cmd-text -s :open")

    config.bind("T".upper(), "hint all tab")
    config.bind("H".upper(), "set-cmd-text -s :open -t")


##########################################################
# Movement
##########################################################

config.bind(key.left, "scroll left")
config.bind(key.down, "scroll down")
config.bind(key.up, "scroll up")
config.bind(key.right, "scroll right")

config.bind(key.next, "search-next")
config.bind(key.next.upper(), "search-prev")

for k, v in {
    key.up: "scroll-px 0 -100",
    key.down: "scroll-px 0  100",
    key.left: "back",
    key.right: "forward",
    key.tabL: "tab-prev",
    key.tabR: "tab-next",
}.items():
    config.bind(k.upper(), v)


##########################################################
# Insert mode
##########################################################

config.bind(key.insert, "mode-enter insert")
config.bind("<Alt-k>", "mode-enter normal", mode="insert")

c.input.insert_mode.auto_leave = False


##########################################################
# Caret mode
##########################################################

config.bind(key.left, "move-to-prev-char", mode="caret")
config.bind(key.up, "move-to-prev-line", mode="caret")
config.bind(key.down, "move-to-next-line", mode="caret")
config.bind(key.right, "move-to-next-char", mode="caret")


##########################################################
# devtools
##########################################################

# Clear old binds
config.unbind("wIh")
config.unbind("wIj")
config.unbind("wIk")
config.unbind("wIl")

config.bind("wIf", "devtools-focus")
config.bind("wIw", "devtools window")
config.bind("wI" + key.left,  "devtools left")
config.bind("wI" + key.down,  "devtools bottom")
config.bind("wI" + key.up,    "devtools top")
config.bind("wI" + key.right, "devtools right")
