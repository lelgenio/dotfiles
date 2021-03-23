# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|


function cabbr
    command -qs ( echo $argv[2] | cut -d' ' -f1 )
    and abbr -g $argv; end
function calias
    command -qs ( echo $argv[2] | cut -d' ' -f1 )
    and alias $argv; end


abbr -g mpn ncmpcpp
abbr -g dot "dotdrop install -f"

cabbr p emerge

cabbr p pacman
cabbr p pikaur
cabbr p yay
cabbr p paru


################################################################
# Editor
################################################################

cabbr v {{@@ editor @@}}

cabbr rv sudo {{@@ editor @@}}
cabbr rv doas {{@@ editor @@}}


################################################################
# Safe guard for rm
################################################################

calias rm  trash
abbr -g  crm command rm -i

################################################################
# ls and cat
################################################################

calias ls 'exa --git'
calias cat 'bat'
calias ip 'ip --color=auto'

################################################################
# Chang Directory
################################################################

# The ever usefull "z" command
command -qs zoxide &&
    zoxide init fish | source

for i in (seq 3 10)
    set -l dots (string repeat -n $i .)
    set -l segs (string repeat -n $i ./.)
    alias $dots "cd $segs"
end


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

abbr -g g  'git'
abbr -g gs 'git status'
abbr -g gd 'git diff'
abbr -g gp 'git pull; git push'
abbr -g gc 'git commit'
abbr -g gr 'cd (git root)'


################################################################
# open
################################################################

function open -w xdg-open
    xdg-open $argv &> /dev/null & disown
end

################################################################
# quickly edit dotfiles
################################################################

function edit-config
    pushd "{{@@ parent_dir ( _dotdrop_dotpath ) @@}}"
    set -l dotfile (fd -HE .git | wdmenu)
    test -n "$dotfile" || return 1
    {{@@ editor @@}} "$dotfile"
    popd
end
abbr -g ec edit-config
