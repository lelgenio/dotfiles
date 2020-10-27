# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

# Environment Vairables {{{
set -x QT_QPA_PLATFORMTHEME gtk3
set -x PATH ~/.local/bin ~/.cargo/bin $PATH

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

command -qs sudo &&
    abbr rv sudo nvim
command -qs doas &&
    abbr rv doas nvim

command -qs trash &&
    alias rm trash

command -qs exa &&
    alias ls 'exa --git'
{%@@ set bat_command = "bat " + ("--theme GitHub" * (color.type == "light")) @@%}
command -qs bat &&
    alias cat "{{@@ bat_command @@}}"

command -qs zoxide &&
    zoxide init fish | source

command -qs khard &&
    function fish_greeting
        set -l khalList khal list now 10d --format " {title}"
        $khalList &> /dev/null
            or return
        $khalList | grep '^No events$' &> /dev/null
            and return
        $khalList
    end

abbr mpn ncmpcpp

abbr gs git status
abbr gd git diff
abbr gp 'git pull; git push'

set -x _KEYBOARD_LAYOUT "{{@@ key_layout        @@}}"
set -x _COLOR_TYPE      "{{@@ color_type        @@}}"
set -x _ACCENT_COLOR    "{{@@ accent_color_name @@}}"

set -x DOTDROP_CONFIG   "{{@@ _dotdrop_cfgpath  @@}}"
set -x DOTDROP_PROFILE  "{{@@ profile           @@}}"
abbr dot "dotdrop install -f"

# }}}
# Functions {{{

function edit-config #{{{
    pushd .
    cd "{{@@ parent_dir ( _dotdrop_dotpath ) @@}}"
    nvim +Files
    popd
end
abbr ec edit-config

#}}}
# alias mutt #{{{

function mutt --wraps=neomutt
  neomutt  $argv;
  pkill -RTMIN+4 waybar
end
abbr neomutt mutt
#}}}
function rcd #{{{
    set file (mktemp)

    ranger --choosedir=$file
    cd (cat $file)

    rm $file
    clear
    ls
    fish_prompt
end

# force-repaint to redraw prompt
bind -M insert \cr rcd
#}}}
function etc #{{{
    cd /etc/
    set file /etc/(fzf)
    cd -
    test -f "$file"
    and sudo nvim $file
end
#}}}
# cd ...{{{
for i in (seq 3 10)
    set -l dots (string repeat -n $i .)
    set -l segs (string repeat -n $i ./.)
    alias $dots "cd $segs"
end
#}}}
# Autoreload{{{
function _fish_autoreload --on-signal SIGHUP
    source {{@@ _dotfile_abs_dst @@}}
    kitty @ set-colors -a ~/.config/kitty/kitty.conf
    kitty @ set-background-opacity "{{@@ opacity @@}}"
end
#}}}
function dark_toggle # {{{
    if test "$_COLOR_TYPE" = "dark"
        set  _COLOR_TYPE "light"
    else
        set  _COLOR_TYPE "dark"
    end

    set -l gArgs -C "{{@@ parent_dir ( _dotdrop_dotpath ) @@}}"
    git $gArgs stash push
    dotdrop install -f
    git $gArgs stash pop

end

# }}}
# Open{{{
functions -q _fish_open
    or functions -c open _fish_open
function open
    _fish_open $argv &> /dev/null
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

    bind -m insert {{@@ key.insertMode         @@}} repaint-mode
    bind -m insert {{@@ key.insertMode.upper() @@}} beginning-of-line repaint-mode

    bind -M insert {{@@ key.insertQuit @@}} repaint-mode -m default

    bind yy fish_clipboard_copy

end

#}}}
# start window manager if using tty1 {{{
#

function esway
    clear

    set -x _JAVA_AWT_WM_NONREPARENTING 1

    set -x GTK_CSD 0
    test -f &&
        set -x LD_PRELOAD '/usr/lib/libgtk3-nocsd.so.0'

    # set -x QT_SCALE_FACTOR 1.0001
    # set -x QPA_PLATFORM wayland
    # set -x QT_QPA_PLATFORM wayland

    set -x XDG_CURRENT_DESKTOP  sway
    set -x XDG_SESSION_TYPE     wayland

    pidof sway || exec sway
end

if test "$XDG_VTNR" = 1 -a -z "$DISPLAY"
    esway &| tee .swaylog
    # ei3 &> .i3log
    # ebsp &> .bsplog
end

# }}}
# use tmux{{{

if test -z "$TMUX" -a -n "$DISPLAY" -a -z "$GNOME_TERMINAL_SCREEN"
    and not string match -qr kitty "$TERM"
    and status is-interactive

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
# Prompt customization{{{

# Fine, I'll do it myself
function fish_vi_cursor;end
function fish_mode_prompt;end

function _fish_prompt_color -a color
    # separate line needed for bold normal
    set_color $color
    set_color --bold
    set -e argv[1]
    echo -en $argv
end

alias _fish_prompt_accent "_fish_prompt_color '{{@@ accent_color @@}}'"
alias _fish_prompt_warn   "_fish_prompt_color 'yellow'"

alias _fish_prompt_normal "_fish_prompt_color 'normal'"

function _fish_prompt_git_status
    git status -s | grep "^$argv[1]" &> /dev/null &&
    _fish_prompt_color $argv[3] $argv[2]
end

function fish_prompt
    set _status $status

    _fish_prompt_accent $USER
    _fish_prompt_normal " in "
    _fish_prompt_accent (prompt_pwd)
    if git status -s &> /dev/null
        set _git_branch (git branch | perl -ne 'print $1 if /^\* (.*)$/')

        _fish_prompt_normal " on "

        _fish_prompt_git_status '.M' '~' '{{@@ color.normal.yellow   @@}}'
        _fish_prompt_git_status '.D' '-' '{{@@ color.normal.red      @@}}'

        _fish_prompt_git_status '??' '?' '{{@@ color.txt             @@}}'
        _fish_prompt_accent "$_git_branch"
        for remote in (git remote)
            if not git diff --quiet HEAD "$remote"/"$_git_branch"
                _fish_prompt_color '{{@@ color.txt @@}}' '↑'
            end
        end

        _fish_prompt_git_status 'A.' '+' '{{@@ color.normal.green    @@}}'
        _fish_prompt_git_status 'M.' '~' '{{@@ color.normal.green    @@}}'
        _fish_prompt_git_status 'D.' '-' '{{@@ color.normal.red      @@}}'
    end

    echo

    if test $fish_key_bindings = fish_vi_key_bindings

        # Set cursor shape
        if test $fish_bind_mode = insert
            printf '\e[5 q' # Bar
        else
            printf '\e[1 q' # Block
        end

        _fish_prompt_accent (
        switch $fish_bind_mode
            case replace_one
                printf 'o'
            case default
                printf 'n'
            case '*'
                printf (string match -r '^.' $fish_bind_mode )
        end | string upper
        )' '
    end

    if test $_status -ne 0
        _fish_prompt_warn "$_status "
    end

    if test $USER = root
        _fish_prompt_normal '# '
    else
        _fish_prompt_normal '$ '
    end

    set_color normal
end

# set fish_cursor_default     block      blink
# set fish_cursor_insert      line       blink
# set fish_cursor_replace_one underscore blink
# set fish_cursor_visual      block

#}}}
# Fish colors{{{

set fish_color_comment yellow

set fish_color_redirection purple
set fish_color_end purple
set fish_color_operator purple

set fish_color_command green
set fish_color_param default
set fish_color_autosuggestion --dim default

set fish_pager_color_selected_background --background={{@@ color.bg_light @@}}
set fish_pager_color_prefix default --bold
set fish_pager_color_completion default
set fish_pager_color_description yellow

#}}}
# Color man pages{{{

set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

#}}}
# Fzf settings{{{

set -x FZF_DEFAULT_OPTS "\
--preview '{{@@ bat_command @@}} --style=numbers --color=always {}' \
--color='\
bg+:{{@@ color.bg_light @@}},\
hl+:{{@@ color.normal.green @@}},\
gutter:{{@@ color.bg @@}},\
prompt:{{@@ accent_color @@}},\
pointer:{{@@ accent_color @@}},\
spinner:{{@@ accent_color @@}}\
'"

#}}}
# vim:foldmethod=marker
