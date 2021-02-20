# {{@@ header() @@}}

hook global NormalIdle .* %{ try %{
    palette-status
    git show-diff
} }

hook global NormalIdle .* %{
    source ~/.config/kak/colors.kak
} -group source-colors

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

hook global BufOpenFile .*/COMMIT_EDITMSG %{
    execute-keys -draft 'ge<a-!>git log<ret>'
    write
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

# Highlight Dotdrop templating syntax
hook global WinCreate .* %{
    {%@@ set escape = "\{\{@@,@@\}\},\{%@@,@@%\},\{#@@,@@#\}".split(",") @@%}

    require-module python
    add-highlighter window/dotdrop regions

    add-highlighter window/dotdrop/expression region '{{@@ escape[0] @@}}' '{{@@ escape[1] @@}}' group
    add-highlighter window/dotdrop/statement  region '{{@@ escape[2] @@}}' '{{@@ escape[3] @@}}' group
    add-highlighter window/dotdrop/comment    region '{{@@ escape[4] @@}}' '{{@@ escape[5] @@}}' fill comment

    add-highlighter window/dotdrop/expression/ ref python
    add-highlighter window/dotdrop/statement/  ref python

    add-highlighter window/dotdrop/expression/ regex '{{@@ escape[0] @@}}|{{@@ escape[1] @@}}' 0:block
    add-highlighter window/dotdrop/statement/  regex '{{@@ escape[2] @@}}|{{@@ escape[3] @@}}' 0:block
    add-highlighter window/dotdrop/statement/  regex 'endfor|endif'                            0:keyword
}

