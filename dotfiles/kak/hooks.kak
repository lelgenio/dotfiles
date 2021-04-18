# {{@@ header() @@}}

set global idle_timeout 500

hook global NormalIdle .* %{ try %{
    palette-status
} }

# enable flag-lines hl for git diff
hook global WinCreate .* %{
    add-highlighter window/git-diff flag-lines Default git_diff_flags
}
# trigger update diff if inside git dir
hook global BufOpenFile .* %{
    evaluate-commands -draft %sh{
        cd $(dirname "$kak_buffile")
        git rev-parse --git-dir 2>/dev/null &&
        printf "hook buffer -group git-update-diff NormalIdle .* 'git update-diff'\n"
    }
}

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

