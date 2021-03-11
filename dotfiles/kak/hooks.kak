# {{@@ header() @@}}

hook global NormalIdle .* %{ try %{
    palette-status
    git show-diff
} }

hook global BufOpenFile .* %{
    modeline-parse
}

hook global BufOpenFile .*/COMMIT_EDITMSG %{
    execute-keys -draft 'ge<a-!>git log<ret>'
    write
}

hook global RegisterModified '"' %{ nop %sh{
      printf %s "$kak_main_reg_dquote" | wl-copy -n > /dev/null 2>&1 &
      printf %s "$kak_main_reg_dquote" | xclip -i -selection clipboard > /dev/null 2>&1 &
}}

# Trim trailing whitespace
hook global BufWritePre .* %{ try %{
    execute-keys -draft \%s\h+$<ret>d
} } -group remove-whitespace

