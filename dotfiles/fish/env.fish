# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

set -x QT_QPA_PLATFORMTHEME gtk2
set -x DESKTOP_APP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY 1
set -x SDL_GAMECONTROLLERCONFIG '050000004c0500006802000000800000,Sony PLAYSTATION(R)3 Controller,a:b0,b:b1,x:b3,y:b2,back:b8,guide:b10,start:b9,leftstick:b11,rightstick:b12,leftshoulder:b4,rightshoulder:b5,dpup:b13,dpdown:b14,dpleft:b15,dpright:b16,leftx:a0,lefty:a1,rightx:a3,righty:a4,lefttrigger:a2,righttrigger:a5,platform:Linux,'

set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share"
set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:$HOME/.local/share/flatpak/exports/share"
set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:/usr/share"
set -x XDG_DATA_DIRS "$XDG_DATA_DIRS:$HOME/.local/share"

set -x XDG_CONFIG_HOME "$HOME/.config/"

set __cargo_asdf_bin ~/.asdf/installs/rust/*/bin/
set __yarn_asdf_bin ~/.config/yarn/global/node_modules/.bin/

for i in ~/.local/bin $__cargo_asdf_bin $__yarn_asdf_bin ~/.yarn/bin ~/.factorio/bin/*
    test -d "$i";and fish_add_path "$i"
end

# needed for tmux
set -x ESCDELAY 0

################################################################
# Default applications
################################################################
set -x EDITOR {{@@ editor @@}}
set -x VISUAL {{@@ editor @@}}
set -x BROWSER any-browser
set -x PAGER less
set -x MANPAGER less

if test "$EDITOR" = "kak"
    set -x PAGER kak-pager
    set -x MANPAGER kak-man-pager
end

################################################################
# keep my dirs clean
################################################################

if test "$USER" != "root"
    set -x PYTHONPYCACHEPREFIX "$HOME/.cache/python"
    set -x MYPY_CACHE_DIR "$HOME/.cache/mypy"
else
    set -e PYTHONPYCACHEPREFIX
    set -e MYPY_CACHE_DIR
end


set -x CMAKE_EXPORT_COMPILE_COMMANDS 1

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

set -x DOTDROP_WORKERS  (math 2 \* (nproc))
