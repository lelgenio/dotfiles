# {{@@ header() @@}}

hook global NormalIdle .* %{ try %{
    palette-status
    source ~/.config/kak/colors.kak
    git show-diff
} }

hook global WinSetOption filetype=rust|c|cpp %{
  hook window BufReload  .* lsp-semantic-tokens
  hook window NormalIdle .* lsp-semantic-tokens
  hook window InsertIdle .* lsp-semantic-tokens
}

hook global WinSetOption filetype=rust %{
    hook window NormalIdle .* rust-analyzer-inlay-hints
}

hook global BufOpenFile .* %{
    modeline-parse
    lsp-enable
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

# Trim trailing whitespace
hook global BufWritePre .* %{ try %{
    execute-keys -draft \%s\h+$<ret>d
} }


