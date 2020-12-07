# {{@@ header() @@}}
#  _  __     _
# | |/ /__ _| | _____  _   _ _ __   ___
# | ' // _` | |/ / _ \| | | | '_ \ / _ \
# | . \ (_| |   < (_) | |_| | | | |  __/
# |_|\_\__,_|_|\_\___/ \__,_|_| |_|\___|

set global tabstop 4

{%@@ if tabs @@%}
#################################################################
# Tabs
#################################################################

    # This means use tabs for `>` and `<`
    set global indentwidth 0

    # yaml is ass and does not allow tabs for indent
    hook global BufOpenFile .*\.ya?ml %{
        set buffer tabstop 2
        execute-keys -draft '%s^\s*<ret><a-@>'
    } -group kakrc-replace-spaces-with-tabs

    hook global BufWritePre  .*\.ya?ml %{
        execute-keys -draft '%s^\s*<ret>@'
    } -group kakrc-replace-spaces-with-tabs

{%@@ else @@%}
#################################################################
# Spaces
#################################################################

    set global indentwidth 4

    # use spaces insted of tabs
    hook global InsertChar \t %{
        exec -draft -itersel h@
    } -group kakrc-replace-tabs-with-spaces

{%@@ endif @@%}
