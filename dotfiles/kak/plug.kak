# {{@@ header() @@}}

nop %sh{
    PLUG_DIR="$HOME/.config/kak/plugins/"
    REPO="https://github.com/robertmeta/plug.kak.git"

    mkdir -p "$PLUG_DIR"

    test -d "${PLUG_DIR}/plug.kak" ||
        git clone "$REPO" "${PLUG_DIR}/plug.kak"
}

source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug 'alexherbo2/prelude.kak'
plug 'alexherbo2/auto-pairs.kak'
plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'
plug 'insipx/kak-crosshairs'

plug 'kak-lsp/kak-lsp'


try %{
    require-module 'prelude'
    require-module 'auto-pairs'
    auto-pairs-enable

    cursorline

    # LSP
    lsp-auto-hover-enable
    set global lsp_hover_max_lines 10

} catch %{
    plug-install
}

