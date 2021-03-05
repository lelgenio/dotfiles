# {{@@ header() @@}}

map global user 'g' ': enter-user-mode lsp<ret>' -docstring 'lsp mode'
map global user 'z' ':zoxide ' -docstring 'zoxide'

map global user 'e' 'x|emmet<ret>{{@@ "@" if not tabs @@}}' -docstring 'process line with emmet'
map global user 'm' ': format-buffer<ret>' -docstring 'format document'
map global user 'M' ': format-selections<ret>' -docstring 'format selection'

map global user 'c' ': comment-line<ret>' -docstring 'comment line'
map global user 'C' ': comment-block<ret>' -docstring 'comment block'

map global user 'p' '<a-!> wl-paste -n <ret>' -docstring 'clipboard paste'
map global user 'P' '! wl-paste -n <ret>' -docstring 'clipboard paste before'
map global user 'R' '"_d! wl-paste -n <ret>' -docstring 'clipboard replace'

declare-user-mode surround
map global user 's' ': enter-user-mode surround<ret>' -docstring 'surround mode'
map global surround 's' ': surround<ret>' -docstring 'surround'
map global surround 'c' ': change-surround<ret>' -docstring 'change'
map global surround 'd' ': delete-surround<ret>' -docstring 'delete'
map global surround 'x' ': select-surround<ret>' -docstring 'select surround'

declare-user-mode git
map global user 'v'    ': enter-user-mode git<ret>' -docstring 'git vcs mode'
map global git 's'     ': git status<ret>' -docstring 'status'
map global git 'a'     ': git add<ret>' -docstring 'add current'
map global git 'd'     ': git diff %reg{%}<ret>' -docstring 'diff current'
map global git 'r'     ': git restore %reg{%}<ret>' -docstring 'restore current'
map global git 'A'     ': git add --all<ret>' -docstring 'add all'
map global git 'D'     ': git diff<ret>' -docstring 'diff all'
map global git '<a-d>' ': git diff --staged<ret>' -docstring 'diff staged'
map global git 'c'     ': git commit -v<ret>' -docstring 'commit'
map global git 'n'     ': git next-hunk <ret>' -docstring 'next hunk'
map global git 'p'     ': git prev-hunk <ret>' -docstring 'previous hunk'

declare-user-mode find
map global user 'f' ': enter-user-mode find<ret>' -docstring 'find mode'
map global find 'f' ': find_file<ret>' -docstring 'file'
map global find 'r' ': find_ripgrep<ret>' -docstring 'ripgrep all file'
map global find 'g' ': find_git_file<ret>' -docstring 'git files'
map global find 'c' ': find_dir<ret>' -docstring 'change dir'
map global find 'b' ': find_buffer<ret>' -docstring 'find buffer'
map global find 'd' ': find_delete<ret>' -docstring 'file to delete'


define-command -hidden find_file \
%{ edit -existing %sh{
    test "$PWD" -ne "$HOME" && args="-H"
    fd -tf "$args" | sed "/.git\//d" | wdmenu
} }

define-command -hidden find_delete \
%{ nop %sh{
    test "$PWD" -ne "$HOME" && args="-H"
    fd -tf "$args" | sed "/.git\//d" | wdmenu | xargs trash
} }

define-command -hidden find_git_file \
%{ edit -existing %sh{ git ls-files | wdmenu } }

define-command -hidden find_dir \
%{ cd %sh{ fd -Htd | wdmenu } }

define-command -hidden find_buffer \
%{ buffer %sh{
    printf "%s\n" $kak_buflist | wdmenu
} }

define-command -hidden find_ripgrep \
%{ eval %sh{
    patter=$( wdmenu -p "Regex")
    rg --column -n "$patter" | wdmenu |
        perl -ne 'print "edit \"$1\" \"$2\" \"$3\" " if /(.+):(\d+):(\d+):/'
} }


define-command -params .. \
-shell-script-candidates 'zoxide query -l' \
zoxide \
%{
    cd %sh{ zoxide query "$@" || echo "$@" }
    echo %sh{ pwd | sed "s|$HOME|~|" }
}

