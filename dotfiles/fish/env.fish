# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

set -x QT_QPA_PLATFORMTHEME gtk3
set -x PATH ~/.local/bin ~/.cargo/bin $PATH
set -x ESCDELAY 0

################################################################
# Default applications
################################################################
set -x EDITOR {{@@ editor @@}}
set -x VISUAL {{@@ editor @@}}
set -x BROWSER qutebrowser
set -x PAGER less

################################################################
# keep my dirs clean
################################################################
set -x PYTHONPYCACHEPREFIX "$HOME/.cache/python"
set -x MYPY_CACHE_DIR "$HOME/.cache/mypy"

################################################################
# Color man pages
################################################################

set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")


################################################################
# Fzf settings
################################################################

set -x FZF_DEFAULT_OPTS "\
--preview 'bat --style=numbers --color=always {}' \
--color='\
bg+:{{@@ color.bg_light @@}},\
hl+:{{@@ color.normal.green @@}},\
gutter:{{@@ color.bg @@}},\
prompt:{{@@ accent_color @@}},\
pointer:{{@@ accent_color @@}},\
spinner:{{@@ accent_color @@}}\
'"


################################################################
# Dotdrop
################################################################

set -x _KEYBOARD_LAYOUT "{{@@ key_layout        @@}}"
set -x _COLOR_TYPE      "{{@@ color_type        @@}}"
set -x _ACCENT_COLOR    "{{@@ accent_color_name @@}}"

set -x DOTDROP_CONFIG   "{{@@ _dotdrop_cfgpath  @@}}"
set -x DOTDROP_PROFILE  "{{@@ profile           @@}}"
