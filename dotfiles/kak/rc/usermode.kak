# {{@@ header() @@}}

map global user 'f' ': fzf-mode<ret>'                   -docstring 'fzf mode'
map global user 'g' ': enter-user-mode lsp<ret>'        -docstring 'lsp mode'

map global user 'c' ': comment-line<ret>'               -docstring 'comment line'
map global user 'C' ': comment-block<ret>'              -docstring 'comment block'

map global user 'p' '<a-!> wl-paste -n <ret>'           -docstring 'clipboard paste'
map global user 'P' '! wl-paste -n <ret>'               -docstring 'clipboard paste before'

declare-user-mode surround
map global surround 's' ': surround<ret>'               -docstring 'surround'
map global surround 'c' ': change-surround<ret>'        -docstring 'change'
map global surround 'd' ': delete-surround<ret>'        -docstring 'delete'
map global surround 't' ': select-surrounding-tag<ret>' -docstring 'select tag'
map global user 's' ': enter-user-mode surround<ret>'   -docstring 'surround mode'

declare-user-mode git
map global git 's' ': git status<ret>'                  -docstring 'status'
map global git 'a' ': git add<ret>'                     -docstring 'add current'
map global git 'A' ': git add .<ret>'                   -docstring 'add'
map global git 'd' ': git diff %reg{%}<ret>'            -docstring 'diff current'
map global git 'D' ': git diff<ret>'                    -docstring 'diff'
map global git '<a-d>' ': git diff --staged<ret>'       -docstring 'diff staged'
map global git 'c' ': git commit -v<ret>'               -docstring 'commit'
map global user 'v' ': enter-user-mode git<ret>'        -docstring 'git vcs mode'


def -hidden insert-c-n %{
 try %{
   lsp-snippets-select-next-placeholders
   exec '<a-;>d'
 } catch %{
   exec -with-hooks '<c-n>'
 }
}
map global insert <c-n> "<a-;>: insert-c-n<ret>"

# map global insert <s-tab> '<a-;><lt>'
