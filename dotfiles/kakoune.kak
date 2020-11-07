source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "andreyorst/fzf.kak"
plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
}

{%@@ set keys = {
    "h": key.left,
    "j": key.down,
    "k": key.up,
    "l": key.right,
    "i": key.insertMode,
} @@%}

{%@@ for old, new in keys.items() @@%}
    map global normal {{@@ new @@}} {{@@ old @@}}
    map global normal {{@@ new.upper() @@}} {{@@ old.upper() @@}}
    map global normal <a-{{@@ new @@}}> <a-{{@@ old @@}}>
    map global normal <a-{{@@ new.upper() @@}}> <a-{{@@ old.upper() @@}}>
    map global goto   {{@@ new @@}} {{@@ old @@}}
{%@@ endfor @@%}

{%@@ if key.layout == 'colemak' @@%}
    map global normal h o
    map global normal H O

    map global normal k s
    map global normal K S
    map global normal <a-k> <a-s>

    map global normal l n

    map global normal t e
{%@@ endif @@%}

# Kakoune default color scheme
{%@@ set accent = "rgb:%s" % accent_color.replace('#','') @@%}

# For Code
face global value default
face global type yellow
face global variable default
face global module value
face global function cyan
face global string green
face global keyword {{@@ accent @@}}
face global operator yellow
face global attribute green
face global comment black
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

face global LineNumbers default,default
face global LineNumberCursor default,default+r

face global MenuForeground white,red
face global MenuBackground white,black
face global MenuInfo cyan

face global Information black,yellow
face global Error white,default

face global StatusLine      black,  default
face global StatusLineMode  black,default
face global StatusLineInfo  black,  default
face global StatusLineValue black, default
face global StatusCursor    black, default

face global Prompt yellow,default
face global MatchingChar default,default+b

face global Whitespace default,default+f
face global BufferPadding blue,default
