# {{@@ header() @@}}

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

{%@@ if key.layout == 'colemak' @@%}
    map global normal k s
    map global normal K S
    map global normal <c-k> <a-s>

    map global normal t e

{%@@ endif @@%}

######################################################
# Emacs-like insert
######################################################

map global insert <c-b> "<a-;>h"
map global insert <c-f> "<a-;>l"

map global insert <a-b> "<a-;>b"
map global insert <a-f> "<a-;>w"

map global insert <c-a> "<a-;>gi"
map global insert <c-e> "<a-;>gl<right>"
map global insert <c-w> "<a-;>b<a-;>d"
