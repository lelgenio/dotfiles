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
cabbr ytd "yt-dlp --merge-output-format mp4"

cabbr p emerge

if command -qs xbps-install
    cabbr p sudo xbps-install -y
end

cabbr p pacman
cabbr p pikaur
cabbr p yay
cabbr p paru


################################################################
# Editor
################################################################

{%@@ if editor == "kak" @@%}
function kak --wraps kak
    if contains -- -s $argv > /dev/null
        or contains -- -c $argv > /dev/null
        command kak $argv
        return
    end
    set -l session (
        echo $PWD |
        string replace -r "$HOME/?" '' |
        string replace -a '/' '_'
    )
    if test $HOME = $PWD
        set session (basename $PWD)
    end
    command kak -c $session $argv 2> /dev/null
    or command kak -s $session $argv
    or command kak $argv
end
{%@@ endif @@%}

cabbr v {{@@ editor @@}}

cabbr rv sudoedit
cabbr rv doas {{@@ editor @@}}


################################################################
# Safe guard for rm
################################################################

calias rm  trash
abbr -g  crm command rm -i

################################################################
# ls and cat
################################################################

calias ls 'exa --git --sort newest'
calias tree 'exa --git --tree --icons --git-ignore'
calias cat 'bat -p'
calias cp 'cp --reflink=auto'
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

function fish_greeting
    command -qs khal
        or return
    set -l khalList (khal --color list now 5d)
    test -n "$khalList"
        or return
    echo $khalList | strip-escape | string match -qr '^No events$'
        and return
    printf "%s\n" $khalList
end

function fish_greeting
end

################################################################
# Git
################################################################

abbr -g g   'git'
abbr -g ga  'git add'
abbr -g gs  'git status'
abbr -g gsh 'git show'
abbr -g gl  'git log'
abbr -g gg  'git graph'
abbr -g gd  'git diff'
abbr -g gds 'git diff --staged'
abbr -g gc  'git commit'
abbr -g gca 'git commit --all'
abbr -g gcf 'git commit --fixup'
abbr -g gp  'git push -u origin (git branch --show-current)'
abbr -g gw  'git switch'
abbr -g gr  'cd (git root)'
abbr -g gri 'git rebase --interactive FETCH_HEAD'


################################################################
# open
################################################################

function open -w xdg-open
    for i in $argv
        xdg-open $i &> /dev/null & disown
    end
end


################################################################
# Copy files like graphical programs
################################################################

function wl-copy-f
    set -a file
    for arg in (seq 1 (count $argv))
        if test -f "$argv[$arg]"
            set -a file (realpath $argv[$arg])
            set -e argv[$arg]
        end
    end
    if test -n "$file"
        wl-copy $argv -t text/uri-list "file:///$file"
    else
        wl-copy $argv
    end
end

abbr -g wcf 'wl-copy-f'


################################################################
# man
################################################################

functions -q _man
or functions -c man _man

function man -w man
    test "$COLUMNS" -lt 80
    and set -x MANWIDTH "$COLUMNS"
    or  set -x MANWIDTH 80
    _man $argv
end


################################################################
# sv
################################################################

function sv -w sv
    set -l o (command sv $argv 2> /dev/null )
    and printf "%s\n" $o
    or sudo sv $argv
end


################################################################
# quickly edit dotfiles
################################################################

function edit-config
    pushd (dirname "$DOTDROP_CONFIG")
    set -l dotfile (fd --strip-cwd-prefix -HE .git | wdmenu)
    test -n "$dotfile" || return 1
    {{@@ editor @@}} "$dotfile"
    popd
end
abbr -g ec edit-config
