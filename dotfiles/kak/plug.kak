# {{@@ header() @@}}

source "%val{config}/plugins/plug.kak/rc/plug.kak"

{%@@ for p in [ 'prelude', 'auto-pairs', ] @@%}
    plug 'alexherbo2/{{@@ p @@}}.kak'
    require-module '{{@@ p @@}}'
{%@@ endfor @@%}
auto-pairs-enable

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'
plug 'insipx/kak-crosshairs'

plug "kak-lsp/kak-lsp"

def -hidden complete-snippets %{
 try %{
   lsp-snippets-select-next-placeholders
   # exec '<a-;>d'
 } catch %{
   exec -with-hooks '<c-n>'
 }
}
map global insert <c-e> "<a-;>: complete-snippets<ret>"
