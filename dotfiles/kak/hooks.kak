# {{@@ header() @@}}

set global idle_timeout 500

hook global NormalIdle .* %{ try %{
    palette-status
} }

define-command -hidden git-try-show-diff %{
    evaluate-commands -draft %sh{
        test -f "$kak_buffile" || exit 0
        cd $(dirname "$kak_buffile")
        git rev-parse --git-dir &> /dev/null &&
        echo "git show-diff"
    }
}

evaluate-commands %sh{
    for hook in NormalIdle FocusIn FocusOut BufWritePost BufOpenFile; do
        printf "hook global %s .* 'git-try-show-diff'\n" "$hook"
    done
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

