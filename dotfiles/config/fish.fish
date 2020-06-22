# {{@@ header() @@}}
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
set -x BROWSER qutebrowser
set -x PAGER less

# if test -n "$XDG_VTRN"; and test -z "$DISPLAY"
    # or command -qs systemctl;and systemctl -q is-enabled ly

    export _JAVA_AWT_WM_NONREPARENTING=1

    export GTK_CSD=0
    # export LD_PRELOAD='/usr/lib/libgtk3-nocsd.so.0'

    export XCURSOR_THEME=capitaine-cursors
    export GTK_THEME=materia-custom-accent:dark

    # export XDG_CURRENT_DESKTOP=Unity
    export QT_SCALE_FACTOR=1.0001
    export QPA_PLATFORM=wayland
    export QT_QPA_PLATFORM=wayland

# end
#}}}
# Aliases{{{
abbr rv sudo nvim

command -qs exa &&
    alias ls exa

command -qs bat &&
    alias cat bat

abbr gs git status
abbr gp 'git pull; git push'

alias dotdrop "dotdrop --cfg $HOME/dotdrop/config.yaml"

function edit-config #{{{
    cd ~/.config
    set file ~/.config/( fzf )
    cd -

    if test -f "$file"
        commandline -r nvim\ $file
    end
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
# start window manager if using tty1 {{{
#
    function esway
        clear
        # export XDG_CURRENT_DESKTOP=Unity
        pgrep sway || exec sway
    end
    if test "$XDG_VTNR" = 1 -a -z "$DISPLAY" #faster like this
        if command -v systemctl -a systemctl -q is-active graphical.target
            esway &> .swaylog
            # ei3 &> .i3log
            # ebsp &> .bsplog
        end
    end

# }}}
# use tmux{{{
    # set TMUX 1
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
    set SPACEFISH_VI_MODE_SUFIX ""
    set SPACEFISH_VI_MODE_INSERT "I\e[5 q"
    set SPACEFISH_VI_MODE_NORMAL "N"
    set SPACEFISH_VI_MODE_VISUAL "V"
    set SPACEFISH_VI_MODE_REPLACE "R"
    set SPACEFISH_VI_MODE_REPLACE_ONE 	"S"

    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual      block

    # set -l cnf /usr/share/doc/pkgfile/command-not-found.fish
    test -f "$cnf" &&
        source "$cnf"

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
