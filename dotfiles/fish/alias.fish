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

set -l root_cfg (dirname $DOTDROP_CONFIG)/root
alias rootdrop 'sudo dotdrop install -f -c "$root_cfg"'

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
calias tree 'exa --git --tree --icons'
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

command -qs khard &&
    function fish_greeting
        command -qs khal
            or return
        set -l khalList (khal --color list now 10d --format "    {title}")
        test -n "$khalList"
            or return
        echo $khalList | strip-escape | string match -qr '^No events$'
            and return
        printf "%s\n" $khalList
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
abbr -g gr  'cd (git root)'
abbr -g gri 'git rebase --interactive FETCH_HEAD'


################################################################
# work stuff
################################################################

abbr svu sv start apache mariadb
abbr svd sv stop apache mariadb
abbr svs sv status apache mariadb
abbr pname "\
set pname (basename (pwd | sd -- - _))
sd 'DB_DATABASE=.*' DB_DATABASE=\$pname .env
test (count dump/*) -eq 1
and mv dump/* dump/\$pname.sql"
abbr msv "\
string match -r 'DB_DATABASE=(?<db>.*)\$' < .env
set margs -v -u root --password=(_pass_get work_db)"
abbr msc 'echo "CREATE DATABASE $db" | mysql $margs'
abbr msdrop 'echo "DROP DATABASE $db" | mysql $margs'
abbr msl 'mysql $margs $db < dump/$db.sql'
abbr msd 'mariadb-dump $margs $db | mysql_format > dump/$db.sql'
abbr vw  'kak public/**.less resources/**.blade.php (fd -E \'*.min.js\' \'.js$\' public/)'
abbr gdw 'git diff -- "*.less" "*.js" "*.blade.php"'
abbr pl 'php7 artisan serve --host 0.0.0.0 & make watch'

function mysql_format
    sd "\),\(" "),\n\t(" | sd "VALUES \(" "VALUES\n\t("
end


################################################################
# open
################################################################

function open -w xdg-open
    xdg-open $argv &> /dev/null & disown
end


################################################################
# Copy files like graphical programs
################################################################

function wl-copy-f -w wl-copy
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
    set -l dotfile (fd -HE .git | wdmenu)
    test -n "$dotfile" || return 1
    switch $EDITOR
        case kak
            contains dotfiles (kak -l)
            and eval kak -c dotfiles "$dotfile"
            or eval kak -s dotfiles "$dotfile"
        case '*'
            eval $EDITOR "$dotfile"
    end
    popd
end
abbr -g ec edit-config
