# Highlight Dotdrop templating syntax
hook global WinCreate .* %{
    {%@@ set escape = "\{\{@@,@@\}\},\{%@@,@@%\},\{#@@,@@#\}".split(",") @@%}

    require-module python
    add-highlighter window/dotdrop regions

    add-highlighter window/dotdrop/expression region '{{@@ escape[0] @@}}' '{{@@ escape[1] @@}}' group
    add-highlighter window/dotdrop/statement  region '{{@@ escape[2] @@}}' '{{@@ escape[3] @@}}' group
    add-highlighter window/dotdrop/comment    region '{{@@ escape[4] @@}}' '{{@@ escape[5] @@}}' fill comment

    add-highlighter window/dotdrop/expression/ ref python
    add-highlighter window/dotdrop/statement/  ref python

    add-highlighter window/dotdrop/expression/ regex '{{@@ escape[0] @@}}|{{@@ escape[1] @@}}' 0:block
    add-highlighter window/dotdrop/statement/  regex '{{@@ escape[2] @@}}|{{@@ escape[3] @@}}' 0:block
    add-highlighter window/dotdrop/statement/  regex 'endfor|endif'                            0:keyword
}

hook global BufOpenFile .*\.html %{
    set buffer formatcmd 'prettier --parser html'
}
hook global BufOpenFile .*\.vue %{
    set buffer formatcmd 'prettier --parser vue'

    hook buffer InsertCompletionHide {
      execute-keys 'Ghs$1<ret>c'
    }
}


hook global BufCreate .*\.blade.php %[

  require-module php
  add-highlighter buffer/blade regions
  add-highlighter buffer/blade/code default-region group
  add-highlighter buffer/blade/code/statement_lone  regex '@(if|else|endif|foreach|endforeach|include)' 1:keyword

  add-highlighter buffer/blade/expression region '\{\{ ' ' \}\}' ref php
  add-highlighter buffer/blade/statement  region -recurse '\(' '@(if|foreach|include)\(' '\)' ref php
  add-highlighter buffer/blade/comment    region '\{\{--' '--\}\}' fill comment
  set buffer comment_block_beggin '\{\{--'
  set buffer comment_block_end    '--\}\}'

]

hook global BufCreate .*\.less %{
  set buffer formatcmd 'prettier --parser less'
  set buffer comment_line '//'

  require-module css
  set-option buffer filetype css
  add-highlighter shared/css/line-comment region '//' '$' fill comment
}
