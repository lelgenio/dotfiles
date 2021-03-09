# {{@@ header() @@}}
# this is not in colors/ because it loads plugins

{%@@ set accent_fg    = accent_fg     .replace('#','rgb:') @@%}
{%@@ set accent_color = accent_color  .replace('#','rgb:') @@%}
{%@@ set bg_light     = color.bg_light.replace('#','rgb:') @@%}
{%@@ set bg_dark      = color.bg_dark .replace('#','rgb:') @@%}
{%@@ set nontxt       = color.nontxt  .replace('#','rgb:') @@%}

{%@@ set orange  = color.normal.orange  .replace('#','rgb:') @@%}
{%@@ set brown  = color.normal.brown    .replace('#','rgb:') @@%}

face global crosshairs_line     default,{{@@ bg_dark @@}}
face global crosshairs_column   default+b

# For Code
face global value magenta
face global type yellow
face global variable blue
face global module {{@@ brown @@}}
face global function {{@@ orange @@}}
face global string green
face global keyword {{@@ accent_color @@}}
face global operator yellow
face global attribute cyan
face global comment {{@@ bg_light @@}}
face global documentation comment
face global meta function
face global builtin blue

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

face global PrimaryCursor      {{@@ accent_fg @@}},{{@@ accent_color @@}}+fg
face global PrimaryCursorEol   PrimaryCursor
face global PrimarySelection   default,{{@@ bg_light @@}}+f

face global SecondaryCursor    default,default+rfg
face global SecondaryCursorEol SecondaryCursor
face global SecondarySelection default,{{@@ bg_light @@}}+f

face global MenuForeground {{@@ accent_fg @@}},{{@@ accent_color @@}}
face global MenuBackground default,{{@@ bg_dark @@}}
face global MenuInfo cyan

face global Information default,{{@@ bg_dark @@}}
face global Error default

face global StatusLine      default,{{@@ nontxt @@}}
face global StatusLineMode  green,{{@@ nontxt @@}}
face global StatusLineInfo  default,{{@@ nontxt @@}}
face global StatusLineValue default,{{@@ nontxt @@}}
face global StatusCursor    {{@@ accent_fg @@}},{{@@ accent_color @@}}

face global Prompt yellow,default
face global MatchingChar default,default+b

# Goodies
try %{add-highlighter global/ number-lines -relative -hlcursor}
face global LineNumbers         {{@@ bg_light @@}},default
face global LineNumberCursor    default,{{@@ bg_dark @@}}
face global LineNumbersWrapped  red,default

try %{add-highlighter global/ show-whitespaces}
face global Whitespace {{@@ nontxt @@}},default+f
face global BufferPadding {{@@ nontxt @@}},default
## highlight trailing whitespace
# add-highlighter global/ regex '\h*$' 0:red,red+u


# Lsp
{%@@ for obj, col in {
    'Error':       'red',
    'Warning':     'yellow',
    'Hint':        'blue',
}.items() @@%}
    face global HighlightDiagnostic{{@@ obj @@}} {{@@ col @@}},default+bu
    face global Diagnostic{{@@          obj @@}} {{@@ col @@}},default+b
    face global TextDiagnostic{{@@      obj @@}} {{@@ col @@}},default+b
    face global InlayDiagnostic{{@@     obj @@}} {{@@ col @@}},default+br
{%@@ endfor @@%}

face global Reference default+bu
face global InlayHint {{@@ bg_light @@}}

