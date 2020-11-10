#plugins

    source "%val{config}/plugins/plug.kak/rc/plug.kak"

    plug 'delapouite/kakoune-palette'

    plug "andreyorst/fzf.kak"
    plug "kak-lsp/kak-lsp" do %{
        cargo install --locked --force --path .
    }


    lsp-enable
    lsp-inlay-diagnostics-enable global

#syntax

    set global tabstop 4

#keys

    {%@@ for old, new in {
            "h": key.left,
            "j": key.down,
            "k": key.up,
            "l": key.right,
            "i": key.insertMode,
            "n": key.next,
        }.items() @@%}
        map global normal {{@@ new @@}} {{@@ old @@}}
        map global normal {{@@ new.upper() @@}} {{@@ old.upper() @@}}
        map global normal <a-{{@@ new @@}}> <a-{{@@ old @@}}>
        map global normal <a-{{@@ new.upper() @@}}> <a-{{@@ old.upper() @@}}>
        map global goto   {{@@ new @@}} {{@@ old @@}}
    {%@@ endfor @@%}

    {%@@ for old, new in {
            "j": key.down,
            "k": key.up,
        }.items() @@%}
        map global normal <a-{{@@ new @@}}> 10{{@@ old @@}}
        map global normal <a-{{@@ new.upper() @@}}> 10{{@@ old.upper() @@}}
    {%@@ endfor @@%}

    {%@@ if key.layout == 'colemak' @@%}
        map global normal h o
        map global normal H O

        map global normal k s
        map global normal K S
        map global normal <c-k> <a-s>

        map global normal t e

        map global normal <C-n> ': fzf-mode<ret>'
        map global normal <C-e> ': enter-user-mode lsp<ret>'
    {%@@ endif @@%}

    map global normal '#' :comment-line<ret>

    map global insert <s-tab> '<a-;><lt>'

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
    face global attribute yellow+b
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

    face global PrimarySelection   white,black+fg
    face global SecondarySelection white,black+fg
    face global PrimaryCursor      default,{{@@ accent @@}}+fg
    face global SecondaryCursor    black,white+fg
    face global PrimaryCursorEol   black,cyan+fg
    face global SecondaryCursorEol PrimaryCursorEol

    face global LineNumbers      {{@@ bg_light @@}},default
    face global LineNumberCursor white,default

    face global MenuForeground white,{{@@ accent @@}}
    face global MenuBackground white,{{@@ bg_light @@}}
    face global MenuInfo cyan

    face global Information yellow,default
    face global Error white,default

    face global StatusLine      default,default
    face global StatusLineMode  green,default
    face global StatusLineInfo  default,default
    face global StatusLineValue default,default
    face global StatusCursor    default,{{@@ accent @@}}

    face global Prompt yellow,default
    face global MatchingChar default,default+b

    face global Whitespace {{@@ nontxt @@}},default+f
    face global BufferPadding blue,default

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

    face global Reference yellow,default+b
