# {{@@ header() @@}}

source "%val{config}/plugins/plug.kak/rc/plug.kak"

{%@@ for p in [ 'prelude', 'auto-pairs', 'manual-indent' ] @@%}
    plug 'alexherbo2/{{@@ p @@}}.kak'
    require-module '{{@@ p @@}}'
{%@@ endfor @@%}
auto-pairs-enable

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'

plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
}

def -hidden insert-c-n %{
 try %{
   lsp-snippets-select-next-placeholders
   # exec '<a-;>d'
 } catch %{
   exec -with-hooks '<c-n>'
 }
}
map global insert <c-n> "<a-;>: insert-c-n<ret>"
