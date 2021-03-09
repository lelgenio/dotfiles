# {{@@ header() @@}}
#  _  __     _
# | |/ /__ _| | _____  _   _ _ __   ___
# | ' // _` | |/ / _ \| | | | '_ \ / _ \
# | . \ (_| |   < (_) | |_| | | | |  __/
# |_|\_\__,_|_|\_\___/ \__,_|_| |_|\___|

set global tabstop {{@@ indent_width @@}}
{%@@ set small_indent = [2, indent_width / 2] | max @@%}

hook global BufOpenFile .*\.(ya?ml|c(pp)?) %{
    set buffer tabstop {{@@ small_indent @@}}
}

{%@@ if tabs @@%}
#################################################################
# Tabs
#################################################################

    # This means use tabs for `>` and `<`
    set global indentwidth 0

    # yaml is ass and does not allow tabs for indent
    hook global BufOpenFile .*\.ya?ml %{
        execute-keys -draft '%s^\s*<ret><a-@>'
        write
        set buffer autoreload false
    } -group yaml-replace-spaces-with-tabs

    hook global BufWritePost .*\.ya?ml %{ nop %sh{
        tmpf=$(mktemp)
        expand --tabs={{@@ small_indent @@}} --initial "${kak_buffile}" > "${tmpf}"
        cat "${tmpf}" > "${kak_buffile}"
        rm -- "${tmpf}"
    } } -group yaml-replace-spaces-with-tabs

{%@@ else @@%}
#################################################################
# Spaces
#################################################################

    set global indentwidth {{@@ indent_width @@}}

    # use spaces insted of tabs
    hook global BufCreate .* %{
        hook buffer InsertChar \t %{
            exec -draft -itersel h@
        } -group replace-tabs-with-spaces
    }

    hook global WinSetOption filetype=makefile %{
        remove-hooks buffer replace-tabs-with-spaces
    }


{%@@ endif @@%}
