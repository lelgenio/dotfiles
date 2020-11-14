# {{@@ header() @@}}

# not exactly hooks but ok
set global tabstop 4
set global scrolloff 8,8

# use spaces insted of tabs
hook global InsertChar \t %{ exec -draft -itersel h@ } -group kakrc-replace-tabs-with-spaces

hook global NormalIdle .* %{ try %{
    lsp-highlight-references
    git show-diff
    palette-status
} }

hook global BufOpenFile .* %{
    modeline-parse
    lsp-enable
}

hook global WinCreate .* %{
    manual-indent-enable
}

#completion with tab
hook global InsertCompletionShow .* %{ try %{
    execute-keys -draft 'h<a-K>\h<ret>'
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
} }

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
}

hook global RegisterModified '"' %{ nop %sh{
      printf %s "$kak_main_reg_dquote" | wl-copy > /dev/null 2>&1 &
}}

