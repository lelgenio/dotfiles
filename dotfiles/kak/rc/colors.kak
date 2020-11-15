# {{@@ header() @@}}
# this is not in colors/ because it loads plugins

{%@@ set accent = "rgb:%s" % accent_color.replace('#','') @@%}
{%@@ set bg_light = "rgb:%s" % color.bg_light.replace('#','') @@%}
{%@@ set bg_dark = "rgb:%s" % color.bg_dark.replace('#','') @@%}
{%@@ set nontxt = "rgb:%s" % color.nontxt.replace('#','') @@%}

cursorline
face global crosshairs_line     default,{{@@ bg_dark @@}}

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

face global PrimaryCursor      default,{{@@ accent @@}}+fg
face global PrimaryCursorEol   PrimaryCursor
face global PrimarySelection   white,black+fg

face global SecondaryCursor    default,default+rfg
face global SecondaryCursorEol SecondaryCursor
face global SecondarySelection white,black+fg

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

# Goodies
add-highlighter global/ number-lines -relative -hlcursor
face global LineNumbers      {{@@ bg_light @@}},default
face global LineNumberCursor white,{{@@ bg_dark @@}}

add-highlighter global/ show-whitespaces
face global Whitespace {{@@ nontxt @@}},default+f
face global BufferPadding {{@@ nontxt @@}},default
# highlight trailing whitespace
add-highlighter global/ regex '\h*$' 0:red,red+g


# Lsp
{%@@ for obj, col in {
    'Error':       'red',
    'Warning':     'yellow',
    'Hint':        'blue',
}.items() @@%}
    face global HighlightDiagnostic{{@@ obj @@}} {{@@ col @@}},default+bu
    face global Diagnostic{{@@          obj @@}} {{@@ col @@}},default+b
    face global TextDiagnostic{{@@      obj @@}} {{@@ col @@}},default+b
    face global InlayDiagnostic{{@@     obj @@}} {{@@ col @@}},default+bu
{%@@ endfor @@%}

face global Reference yellow,default+b

