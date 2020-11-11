#plugins

    source "%val{config}/plugins/plug.kak/rc/plug.kak"

    {%@@ for p in [ 'prelude', 'auto-pairs', 'manual-indent' ] @@%}
        plug 'alexherbo2/{{@@ p @@}}.kak'
        require-module '{{@@ p @@}}'
    {%@@ endfor @@%}
    auto-pairs-enable

    # Manual indent
    hook global WinCreate .* %{
        manual-indent-enable
    }

    plug 'h-youhei/kakoune-surround'
    plug 'insipx/kak-crosshairs'

    plug 'delapouite/kakoune-palette'

    plug "andreyorst/fzf.kak"
    plug "kak-lsp/kak-lsp" do %{
        cargo install --locked --force --path .
    }


#syntax

    set global tabstop 4

#keys

    {%@@ for old, new, gdoc, vdoc in [
       [ "h", key.left,       "line begin",      "scroll left" ],
       [ "l", key.right,      "line right",      "scroll right" ],
       [ "k", key.up,         "buffer begin",    "scroll up" ],
       [ "j", key.down,       "buffer end",      "scroll down" ],
       [ "i", key.insertMode, "first non blank", "" ],
       [ "n", key.next,       "",                "" ],
       [ "o", "h",            "",                "" ],
    ] @@%}
        {%@@ set NEW, OLD = new.upper(), old.upper()@@%}
        {%@@ if vdoc @@%}
        map global view      {{@@ old @@}}     ''
        map global view      {{@@ new @@}}     {{@@ old @@}} -docstring "{{@@ vdoc @@}}"
        {%@@ endif @@%}
        {%@@ if gdoc @@%}
        map global goto      {{@@ old @@}}     ''
        map global goto      {{@@ new @@}}     {{@@ old @@}} -docstring "{{@@ gdoc @@}}"
        {%@@ endif @@%}
        map global normal    {{@@ new @@}}     {{@@ old @@}}
        map global normal    {{@@ NEW @@}}     {{@@ OLD @@}}
        map global normal <a-{{@@ new @@}}> <a-{{@@ old @@}}>
        map global normal <a-{{@@ NEW @@}}> <a-{{@@ OLD @@}}>
    {%@@ endfor @@%}

    {%@@ for old, new in {
            "j": key.down,
            "k": key.up,
        }.items() @@%}
        map global normal <a-{{@@ new @@}}> 10{{@@ old @@}}
        map global normal <a-{{@@ new.upper() @@}}> 10{{@@ old.upper() @@}}
    {%@@ endfor @@%}

    {%@@ if key.layout == 'colemak' @@%}
        map global normal k s
        map global normal K S
        map global normal <c-k> <a-s>

        map global normal t e

    {%@@ endif @@%}

#usermode
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
    map global git 'c' ': git commit -v<ret>'               -docstring 'commit'
    map global user 'v' ': enter-user-mode git<ret>'        -docstring 'git vcs mode'


    # map global insert <s-tab> '<a-;><lt>'

#hooks

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

    hook global NormalIdle .* %{ try %{
        git show-diff
        palette-status
    } }

    hook global BufOpenFile .* %{
        modeline-parse
    }

    # use spaces insted of tabs
    hook global InsertChar \t %{ exec -draft -itersel h@ } -group kakrc-replace-tabs-with-spaces

    add-highlighter global/ number-lines -relative -hlcursor
    add-highlighter global/ show-whitespaces

#color

    {%@@ set accent = "rgb:%s" % accent_color.replace('#','') @@%}
    {%@@ set bg_light = "rgb:%s" % color.bg_light.replace('#','') @@%}
    {%@@ set bg_dark = "rgb:%s" % color.bg_dark.replace('#','') @@%}
    {%@@ set nontxt = "rgb:%s" % color.nontxt.replace('#','') @@%}

    # For Code
    face global value default
    face global type yellow
    face global variable default
    face global module value
    face global function cyan
    face global string green
    face global keyword {{@@ accent @@}}
    face global operator yellow
    face global attribute green+b
    face global comment {{@@ bg_light @@}}
    face global documentation comment
    face global meta magenta
    face global builtin default+b

    # For markup
    face global title blue
    face global header cyan
    face global mono green
    face global block magenta
    face global link cyan
    face global bullet cyan
    face global list yellow

    # builtin faces
    face global Default default,default


    cursorline
    face global crosshairs_line     default,{{@@ bg_dark @@}}
    face global PrimaryCursor      default,{{@@ accent @@}}+fg
    face global PrimaryCursorEol   PrimaryCursor
    face global PrimarySelection   white,black+fg

    face global SecondaryCursor    default,default+rfg
    face global SecondaryCursorEol SecondaryCursor
    face global SecondarySelection white,black+fg


    face global LineNumbers      {{@@ bg_light @@}},default
    face global LineNumberCursor white,{{@@ bg_dark @@}}

    face global MenuForeground white,{{@@ accent @@}}
    face global MenuBackground white,{{@@ bg_dark @@}}
    face global MenuInfo cyan

    face global Information default,{{@@ bg_dark @@}}
    face global Error white,default

    face global StatusLine      default,{{@@ nontxt @@}}
    face global StatusLineMode  green,{{@@ nontxt @@}}
    face global StatusLineInfo  default,{{@@ nontxt @@}}
    face global StatusLineValue default,{{@@ nontxt @@}}
    face global StatusCursor    default,{{@@ accent @@}}

    face global Prompt yellow,default
    face global MatchingChar default,default+b

    face global Whitespace {{@@ nontxt @@}},default+f
    face global BufferPadding blue,default
    # highlight trailing whitespace
    add-highlighter global/ regex '\h*$' 0:red,red

    #lsp
    {%@@ set cols = {
        'Error':       'red',
        'Warning':     'yellow',
        'Hint':        'blue',
    } @@%}
    #{%@@ for obj, col in cols.items() @@%}#
    face global HighlightDiagnostic{{@@ obj @@}} {{@@ col @@}},default+bu
    face global Diagnostic{{@@          obj @@}} {{@@ col @@}},default+b
    face global TextDiagnostic{{@@      obj @@}} {{@@ col @@}},default+b
    face global InlayDiagnostic{{@@     obj @@}} {{@@ col @@}},default+bu
    #{%@@ endfor @@%}#

    lsp-enable
    lsp-inlay-diagnostics-enable global

    face global Reference yellow,default+b
