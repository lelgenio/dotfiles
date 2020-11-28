# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

abbr mpn ncmpcpp
abbr dot "dotdrop install -f"
abbr p   "paru"

################################################################
# Editor
################################################################

abbr v {{@@ editor @@}}

command -qs sudo &&
    abbr rv sudo {{@@ editor @@}}
command -qs doas &&
    abbr rv doas {{@@ editor @@}}


################################################################
# Safe guard for rm
################################################################

alias rm  'trash'
alias crm 'command rm -i'

################################################################
# ls and cat
################################################################

command -qs exa &&
    alias ls 'exa --git'
command -qs bat &&
    alias cat "bat"

################################################################
# The ever usefull "z" command
################################################################

command -qs zoxide &&
    zoxide init fish | source

################################################################
# Show reminders on startup
################################################################

command -qs khard &&
    function fish_greeting
        set -l khalList khal list now 10d --format " {title}"
        $khalList &> /dev/null
            or return
        $khalList | grep '^No events$' &> /dev/null
            and return
        $khalList
    end


################################################################
# Git
################################################################

abbr g  'git'
abbr gs 'git status'
abbr gd 'git diff'
abbr gp 'git pull; git push'
abbr gc 'git commit -v'


################################################################
# cd ...
################################################################

for i in (seq 3 10)
    set -l dots (string repeat -n $i .)
    set -l segs (string repeat -n $i ./.)
    alias $dots "cd $segs"
end


################################################################
# quickly edit dotfiles
################################################################

function edit-config
    pushd "{{@@ parent_dir ( _dotdrop_dotpath ) @@}}"
    {{@@ editor @@}} (git ls-files | wdmenu)
    popd
end
abbr ec edit-config
