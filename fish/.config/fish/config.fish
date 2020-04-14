#
# LEL
#   __ _     _     
#  / _(_)___| |__  
# | |_| / __| '_ \ 
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

# Environment Vairables {{{
set -x QT_QPA_PLATFORMTHEME qt5ct
set -x PATH $PATH ~/.local/bin

set -x EDITOR nvim
set -x VISUAL nvim
# set -x BROWSER=qutebrowser
set -x PAGER less

#}}}
# start window manager if using tty1 {{{
#
    sh ~/.local/bin/etwm
# }}}
# use tmux{{{
set TMUX 1
    if test -z "$TMUX" && test "$TERM" != "xterm-kitty" && test -n "$DISPLAY"
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
    set SPACEFISH_USER_SHOW always
    set SPACEFISH_USER_COLOR "#cc5757"
    set SPACEFISH_DIR_COLOR "#cc5757"
    
    set SPACEFISH_PROMPT_ADD_NEWLINE false

    set SPACEFISH_CHAR_PREFIX ""
    set SPACEFISH_CHAR_SYMBOL '$'
    set SPACEFISH_CHAR_SYMBOL_ROOT '#'

    set SPACEFISH_VI_MODE_PREFIX ""
    set SPACEFISH_VI_MODE_SUFIX ""
    set SPACEFISH_VI_MODE_INSERT "I"
    set SPACEFISH_VI_MODE_NORMAL "N"
    set SPACEFISH_VI_MODE_VISUAL "V"
    set SPACEFISH_VI_MODE_REPLACE "R"
    set SPACEFISH_VI_MODE_REPLACE_ONE 	"S"

#}}}
# Color man pages{{{

set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

#}}}
source  /usr/share/doc/pkgfile/command-not-found.fish
# vim:foldmethod=marker
