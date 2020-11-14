# {{@@ header() @@}}

source "%val{config}/plugins/plug.kak/rc/plug.kak"

{%@@ for p in [ 'prelude', 'auto-pairs', 'manual-indent' ] @@%}
    plug 'alexherbo2/{{@@ p @@}}.kak'
    require-module '{{@@ p @@}}'
{%@@ endfor @@%}
auto-pairs-enable

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'

plug "andreyorst/fzf.kak"
plug "kak-lsp/kak-lsp" do %{
    cargo install --locked --force --path .
}
