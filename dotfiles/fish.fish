# {{@@ header() @@}}
# LEL
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

# Environment Vairables {{{
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x PATH ~/.local/bin $PATH

set -x EDITOR nvim
set -x VISUAL nvim
set -x BROWSER qutebrowser
set -x PAGER less

# if test -n "$XDG_VTRN"; and test -z "$DISPLAY"
    # or command -qs systemctl;and systemctl -q is-enabled ly


    # keep my dirs clean
    set -x PYTHONPYCACHEPREFIX $HOME/.cache/python

# end
#}}}
# Aliases{{{
abbr v nvim
abbr rv sudo nvim

command -qs trash &&
    alias rm trash

command -qs exa &&
    alias ls exa

command -qs bat &&
    alias cat bat

command -qs khard &&
    function fish_greeting
        set -l khalList khal list now 10d --format " {title}"
        $khalList &> /dev/null
            or return
        $khalList | grep '^No events$' &> /dev/null
            and return
        $khalList
    end

abbr gs git status
abbr gp 'git pull; git push'

alias dotdrop "dotdrop --cfg \"{{@@ _dotdrop_cfgpath @@}}\""

function edit-config #{{{
    cd "{{@@ parent_dir ( _dotdrop_dotpath ) @@}}"
    nvim +GFiles
end
abbr ec edit-config
#}}}
# alias mutt #{{{
function mutt --wraps=neomutt --description 'alias mutt=neomutt'
  neomutt  $argv;
  pkill -RTMIN+4 waybar
end
abbr neomutt mutt
#}}}
function rcd #{{{
    set file (mktemp)

    ranger $argv --choosedir=$file
    cd (cat $file)

    rm $file
    clear
    ls
    fish_prompt
end

# force-repaint to redraw prompt
bind -M insert \co rcd
#}}}
function etc #{{{
    cd /etc/
    set file /etc/(fzf)
    cd -
    test -f "$file"
    and sudo nvim $file
end
#}}}
# }}}
# Keys{{{

set fish_key_bindings fish_vi_key_bindings

if test $fish_key_bindings = fish_vi_key_bindings
    bind           {{@@ key.left  @@}} backward-char
    bind -M visual {{@@ key.left  @@}} backward-char
    bind           {{@@ key.down  @@}} down-or-search
    bind -M visual {{@@ key.down  @@}} down-line
    bind           {{@@ key.up    @@}} up-or-search
    bind -M visual {{@@ key.up    @@}} up-line
    bind           {{@@ key.right @@}} forward-char
    bind -M visual {{@@ key.right @@}} forward-char

    bind -m insert {{@@ key.insertMode @@}} repaint-mode

end
#}}}
# start window manager if using tty1 {{{
#

function esway
    clear

    set -x _JAVA_AWT_WM_NONREPARENTING 1

    set -x GTK_CSD 0
    # set -x LD_PRELOAD '/usr/lib/libgtk3-nocsd.so.0'

    set -x XCURSOR_THEME {{@@ cursor_theme @@}}
    set -x GTK_THEME materia-custom-accent:dark

    # set -x XDG_CURRENT_DESKTOP Unity
    set -x QT_SCALE_FACTOR 1.0001
    set -x QPA_PLATFORM wayland
    set -x QT_QPA_PLATFORM wayland

    # export XDG_CURRENT_DESKTOP=Unity
    pgrep sway || exec sway
end
if test "$XDG_VTNR" = 1 -a -z "$DISPLAY"
    esway &> .swaylog
    # ei3 &> .i3log
    # ebsp &> .bsplog
end

# }}}
# use tmux{{{
    set TMUX 1
    if test -z "$TMUX" -a -n "$DISPLAY" &&
        not string match -qr kitty "$TERM" &&
        test -z "$GNOME_TERMINAL_SCREEN" &&
        status is-interactive
        set attach_session (tmux 2> /dev/null ls -F \
            '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
            awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')
        if test -n "$attach_session"
            exec tmux attach -t "$attach_session"
        else
            exec tmux
        end
    end

# }}}
# Install fisher{{{
    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        fish -c fisher
    end
#}}}
# Prompt customization{{{


# Fine, I'll do it myself
function fish_vi_cursor;end
function fish_mode_prompt;end

# function _fish_prompt_accent
#     set_color --bold "{{@@ color.accent @@}}"
#     echo -en $argv
# end

# function _fish_prompt_normal
#     set_color --bold "brwhite"
#     echo -en $argv
# end

# function fish_prompt
#     _fish_prompt_accent $USER
#     _fish_prompt_normal " in "
#     _fish_prompt_accent (prompt_pwd)
#     echo

#     if test $fish_key_bindings = fish_vi_key_bindings
#         printf '\e[1 q'

#         printf (
#         switch $fish_bind_mode
#             case insert
#                 printf '\e[5 q'
#                 printf 'i'
#             case replace_one
#                 printf 'o'
#             case default
#                 printf 'n'
#             case '*'
#                 printf (string match -r '^.' $fish_bind_mode )
#         end | string upper
#         )' '
#     end

#     if test $USER = root
#         _fish_prompt_normal "\# "
#     else
#         _fish_prompt_normal "\$ "
#     end

#     set_color normal
# end

    set SPACEFISH_USER_SHOW always
    set SPACEFISH_USER_COLOR "{{@@ color.accent @@}}"
    set SPACEFISH_DIR_COLOR  "{{@@ color.accent @@}}"

    set SPACEFISH_PROMPT_ADD_NEWLINE false

    set SPACEFISH_CHAR_COLOR_SUCCESS white
    set SPACEFISH_CHAR_PREFIX ""
    set SPACEFISH_CHAR_SYMBOL '$'
    set SPACEFISH_CHAR_SYMBOL_ROOT '#'

    set SPACEFISH_VI_MODE_COLOR "{{@@ color.accent @@}}"
    set SPACEFISH_VI_MODE_PREFIX "\e[1 q"
    set SPACEFISH_VI_MODE_INSERT "I\e[5 q"
    set SPACEFISH_VI_MODE_NORMAL "N"
    set SPACEFISH_VI_MODE_VISUAL "V"
    set SPACEFISH_VI_MODE_REPLACE "R"
    set SPACEFISH_VI_MODE_REPLACE_ONE 	"S"
    set SPACEFISH_VI_MODE_SUFIX ""

    # set fish_cursor_default     block      blink
    # set fish_cursor_insert      line       blink
    # set fish_cursor_replace_one underscore blink
    # set fish_cursor_visual      block

#}}}
# Color man pages{{{

set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

#}}}
# vim:foldmethod=marker
