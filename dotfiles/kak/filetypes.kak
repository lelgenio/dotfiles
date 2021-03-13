# {{@@ header() @@}}

try %{
    require-module python
    add-highlighter shared/python/code/function regex '\b([a-zA-Z_][a-zA-Z0-9_]*)\s*\(' 1:function
}

hook global WinSetOption filetype=sh %{
    set buffer formatcmd 'shfmt -s -ci -i "{{@@ indent_width @@}}"'
}


hook global BufCreate .*\.html %{
    set buffer formatcmd 'prettier --parser html'
}

hook global BufCreate .*\.vue %{
    set buffer formatcmd 'prettier --parser vue'
    hook buffer InsertCompletionHide {
      execute-keys 'Ghs$1<ret>c'
    }
}

# Highlight Dotdrop templating syntax
hook global WinCreate .* %{
    {%@@ set escape = "\{\{@@,@@\}\},\{%@@,@@%\},\{#@@,@@#\}".split(",") @@%}

    require-module python
    add-highlighter window/dotdrop regions

    add-highlighter window/dotdrop/expression region '{{@@ escape[0] @@}}' '{{@@ escape[1] @@}}' regions
    add-highlighter window/dotdrop/statement  region '{{@@ escape[2] @@}}' '{{@@ escape[3] @@}}' regions
    add-highlighter window/dotdrop/comment    region '{{@@ escape[4] @@}}' '{{@@ escape[5] @@}}' fill comment

    add-highlighter window/dotdrop/expression/code default-region group
    add-highlighter window/dotdrop/statement/code  default-region group

    add-highlighter window/dotdrop/expression/code/ fill variable
    add-highlighter window/dotdrop/statement/code/  fill variable

    add-highlighter window/dotdrop/expression/code/ ref python
    add-highlighter window/dotdrop/statement/code/  ref python

    add-highlighter window/dotdrop/expression/code/ regex '{{@@ escape[0] @@}}|{{@@ escape[1] @@}}' 0:block
    add-highlighter window/dotdrop/statement/code/  regex '{{@@ escape[2] @@}}|{{@@ escape[3] @@}}' 0:block
    add-highlighter window/dotdrop/statement/code/  regex 'endfor|endif'                            0:keyword
}

hook global BufCreate .*\.jsonc %[ set buffer filetype jsonc ]
hook global BufCreate .*\.blade.php %[ set buffer filetype blade ]
hook global BufCreate .*\.less %[ set buffer filetype less ]

hook global WinSetOption filetype=jsonc %[
    require-module json
    add-highlighter buffer/jsonc regions
    add-highlighter buffer/jsonc/base default-region ref json
    add-highlighter buffer/jsonc/double_string region ["] ["] fill string
    add-highlighter buffer/jsonc/line-comment region // $ fill comment
]


hook global WinSetOption filetype=blade %[

  set-option buffer filetype blade

  require-module php
  add-highlighter buffer/blade regions
  add-highlighter buffer/blade/base default-region group
  add-highlighter buffer/blade/base/ ref html

  add-highlighter buffer/blade/expression region '\{\{ ' ' \}\}' ref php
  add-highlighter buffer/blade/statement  region -recurse '\(' '@(if|foreach|include)\s*\(' '\)' ref php
  add-highlighter buffer/blade/base/      regex '@(if|else|endif|foreach|endforeach|include)' 1:keyword

  add-highlighter buffer/blade/comment    region '\{\{--' '--\}\}' fill comment
  set-option buffer comment_block_begin '{{-- '
  set-option buffer comment_block_end   ' --}}'



]

hook global WinSetOption filetype=less  %[
  set buffer formatcmd 'prettier --parser less'

  set      buffer extra_word_chars '_'
  set -add buffer extra_word_chars '-'

  set buffer comment_line '//'
  set buffer comment_block_begin '/*'
  set buffer comment_block_end   '*/'

  require-module css

  add-highlighter buffer/less regions
  add-highlighter buffer/less/code default-region group

  add-highlighter buffer/less/line-comment region // $ fill comment
  add-highlighter buffer/less/comment region /[*] [*]/ fill comment
  add-highlighter buffer/less/double_string region ["] ["] fill string
  add-highlighter buffer/less/single_string region ['] ['] fill string

  add-highlighter buffer/less/code/ regex ([A-Za-z][A-Za-z0-9_-]*)\h*: 1:keyword
  add-highlighter buffer/less/code/ regex :(before|after) 0:attribute
  add-highlighter buffer/less/code/ regex !important 0:keyword

  add-highlighter buffer/less/code/selector   group
  add-highlighter buffer/less/code/selector/ regex         [A-Za-z][A-Za-z0-9_-]* 0:keyword
  add-highlighter buffer/less/code/selector/ regex [*]|[#.][A-Za-z][A-Za-z0-9_-]* 0:variable

  add-highlighter buffer/less/code/ regex (#[0-9A-Fa-f]+)|(\b(\d*\.)?\d+(ch|cm|em|ex|mm|pc|pt|px|rem|vh|vmax|vmin|vw|%)?) 0:value 4:type

  add-highlighter buffer/less/code/ regex (?i)\b(AliceBlue|AntiqueWhite|Aqua|Aquamarine|Azure|Beige|Bisque|Black|BlanchedAlmond|Blue|BlueViolet|Brown|BurlyWood|CadetBlue|Chartreuse|Chocolate|Coral|CornflowerBlue|Cornsilk|Crimson|Cyan|DarkBlue|DarkCyan|DarkGoldenRod|DarkGray|DarkGrey|DarkGreen|DarkKhaki|DarkMagenta|DarkOliveGreen|DarkOrange|DarkOrchid|DarkRed|DarkSalmon|DarkSeaGreen|DarkSlateBlue|DarkSlateGray|DarkSlateGrey|DarkTurquoise|DarkViolet|DeepPink|DeepSkyBlue|DimGray|DimGrey|DodgerBlue|FireBrick|FloralWhite|ForestGreen|Fuchsia|Gainsboro|GhostWhite|Gold|GoldenRod|Gray|Grey|Green|GreenYellow|HoneyDew|HotPink|IndianRed|Indigo|Ivory|Khaki|Lavender|LavenderBlush|LawnGreen|LemonChiffon|LightBlue|LightCoral|LightCyan|LightGoldenRodYellow|LightGray|LightGrey|LightGreen|LightPink|LightSalmon|LightSeaGreen|LightSkyBlue|LightSlateGray|LightSlateGrey|LightSteelBlue|LightYellow|Lime|LimeGreen|Linen|Magenta|Maroon|MediumAquaMarine|MediumBlue|MediumOrchid|MediumPurple|MediumSeaGreen|MediumSlateBlue|MediumSpringGreen|MediumTurquoise|MediumVioletRed|MidnightBlue|MintCream|MistyRose|Moccasin|NavajoWhite|Navy|OldLace|Olive|OliveDrab|Orange|OrangeRed|Orchid|PaleGoldenRod|PaleGreen|PaleTurquoise|PaleVioletRed|PapayaWhip|PeachPuff|Peru|Pink|Plum|PowderBlue|Purple|RebeccaPurple|Red|RosyBrown|RoyalBlue|SaddleBrown|Salmon|SandyBrown|SeaGreen|SeaShell|Sienna|Silver|SkyBlue|SlateBlue|SlateGray|SlateGrey|Snow|SpringGreen|SteelBlue|Tan|Teal|Thistle|Tomato|Turquoise|Violet|Wheat|White|WhiteSmoke|Yellow|YellowGreen)\b 0:value

  add-highlighter buffer/less/code/ regex ([\w-_]+)\s*: 1:attribute
  add-highlighter buffer/less/code/ regex @[\w\d-_]+ 0:variable

]

