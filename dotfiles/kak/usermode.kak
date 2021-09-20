# {{@@ header() @@}}

try %{
    declare-user-mode surround
    declare-user-mode git
    declare-user-mode find
}

map global user 'w' ': w<ret>' -docstring 'write buffer'
map global user 'u' ': config-source<ret>' -docstring 'source configuration'
map global user 'g' ': enter-user-mode lsp<ret>' -docstring 'lsp mode'
map global user 'z' ':zoxide ' -docstring 'zoxide'
map global user 'n' ': new<ret>' -docstring 'new window'

map global user 'e' 'x|emmet<ret>{{@@ "@" if not tabs @@}}' -docstring 'process line with emmet'
map global user 'm' ': try format-buffer catch lsp-formatting<ret>' -docstring 'format document'
map global user 'M' ': try format-selections catch lsp-range-formatting<ret>' -docstring 'format selection'

map global user 'c' ': comment-line<ret>' -docstring 'comment line'
map global user 'C' '_: comment-block<ret>' -docstring 'comment block'

map global user 'p' '! wl-paste -n<ret>' -docstring 'clipboard paste'
map global user 'P' '<a-o>j! wl-paste -n<ret>' -docstring 'clipboard paste on next line'
map global user 'R' '"_d! wl-paste -n <ret>' -docstring 'clipboard replace'

map global user 'b' ': find_buffer<ret>' -docstring 'switch buffer'

map global user 'l' ': lsp-enable-decals<ret>' -docstring 'LSP enable decals'
map global user 'L' ': lsp-disable-decals<ret>' -docstring 'LSP disable decals'

map global user 's' ': enter-user-mode surround<ret>' -docstring 'surround mode'
map global surround 's' ': surround<ret>' -docstring 'surround'
map global surround 'c' ': change-surround<ret>' -docstring 'change'
map global surround 'd' ': delete-surround<ret>' -docstring 'delete'
map global surround 'x' ': select-surround<ret>' -docstring 'select surround'

map global user 'v'    ': enter-user-mode git<ret>' -docstring 'git vcs mode'
map global user 'V'    ': enter-user-mode -lock git<ret>' -docstring 'git vcs mode'
map global git 's'     ': git status<ret>' -docstring 'status'
map global git 'S'     '_: git show %val{selection} --<ret>' -docstring 'show'
map global git 'a'     ': git add<ret>' -docstring 'add current'
map global git 'd'     ': git diff %reg{%}<ret>' -docstring 'diff current'
map global git 'r'     ': git checkout %reg{%}<ret>' -docstring 'restore current'
map global git 'A'     ': git add --all<ret>' -docstring 'add all'
map global git 'D'     ': git diff<ret>' -docstring 'diff all'
map global git '<a-d>' ': git diff --staged<ret>' -docstring 'diff staged'
map global git 'c'     ': git commit -v<ret>' -docstring 'commit'
map global git 'u'     ': git update-diff<ret>' -docstring 'update gutter diff'
map global git 'n'     ': git next-hunk <ret>' -docstring 'next hunk'
map global git 'p'     ': git prev-hunk <ret>' -docstring 'previous hunk'
map global git 'm'     ': git-merge-head <ret>' -docstring 'merge using head'
map global git 'M'     ': git-merge-new <ret>' -docstring 'merge using new'
map global git '<a-m>' ': git-merge-original <ret>' -docstring 'merge using original'

map global user 'f' ': enter-user-mode find<ret>' -docstring 'find mode'
map global find 'f' ': find_file<ret>' -docstring 'file'
map global find 'l' ': find_line<ret>' -docstring 'jump to line'
map global find 'r' ': find_ripgrep<ret>' -docstring 'ripgrep all file'
map global find 'g' ': find_git_file<ret>' -docstring 'git files'
map global find 'c' ': find_dir<ret>' -docstring 'change dir'
map global find 'd' ': find_delete<ret>' -docstring 'file to delete'

define-command -override -hidden find_file \
%{ edit %sh{
    fd -tf -HE .git | wdmenu ||
    echo "$kak_buffile"
} }

define-command -override -hidden find_delete \
%{ nop %sh{
    fd -H -E .git -t f | wdmenu | xargs -r trash
} }

define-command -override -hidden find_git_file \
%{ edit -existing %sh{ git ls-files | wdmenu } }

define-command -override -hidden find_dir \
%{ cd %sh{ fd -Htd | wdmenu } }

define-command -override -hidden find_buffer \
%{ buffer %sh{
    printf "%s\n" $kak_buflist | wdmenu
} }

define-command -override -hidden find_ripgrep \
%{ eval %sh{
    patter=$( wdmenu -p "Regex")
    rg --column -n "$patter" | wdmenu |
        perl -ne 'print "edit \"$1\" \"$2\" \"$3\" " if /(.+):(\d+):(\d+):/'
} }

define-command -override -hidden find_line \
%{ evaluate-commands -save-regs a %{
        execute-keys %{Z%"ayz}
        execute-keys %sh{
            line=$(
                printf "%s\n" "$kak_reg_a" |
                nl -ba -w1 |
                wdmenu -p "Line" |
                cut -f1
            )
            test -n "$line" && echo "${line}gx"
        }
} }


define-command -override -params .. \
-shell-script-candidates 'zoxide query -l' \
zoxide %{
    cd %sh{ zoxide query -- "$@" || echo "$@" }
    echo %sh{ pwd | sed "s|$HOME|~|" }
}

define-command -override  config-source %{
    source "%val{config}/kakrc"
}

define-command -override git-merge-head %{
    evaluate-commands -draft %{
        # delete head marker
        execute-keys <a-/>^<lt>{4,}<ret><a-x>d
        try %{
            # select original marker
            execute-keys /^[|]{4,}<ret>
            # extend to theirs marker
            execute-keys ?^={4,}<ret><a-x>
        } catch %{
            # select theirs marker
            execute-keys /^={4,}<ret><a-x>
        }
        # extend to end marker
        execute-keys ?^<gt>{4,}<ret><a-x>d
    }
} -docstring "merge using head"

define-command -override git-merge-original %{
    evaluate-commands -draft %{
        # select head marker
        execute-keys <a-/>^<lt>{4,}<ret>
        # select to middle of conflict
        execute-keys ?^[|]{4,}<ret><a-x>d
        # select theirs marker
        execute-keys /^={4,}<ret>
        # extend to end marker
        execute-keys ?^<gt>{4,}<ret><a-x>d
    }
} -docstring "merge using original"

define-command -override git-merge-new %{
    evaluate-commands -draft %{
        # select head marker
        execute-keys <a-/>^<lt>{4,}<ret>
        # extend to theirs marker
        execute-keys ?^={4,}\n<ret>d
        # delete end marker
        execute-keys /^<gt>{4,}<ret><a-x>d
    }
} -docstring "merge using new"
