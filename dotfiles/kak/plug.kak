# {{@@ header() @@}}

nop %sh{
    PLUG_DIR="${HOME}/.cache/kakoune_plugins"
    REPO="https://github.com/robertmeta/plug.kak.git"

    mkdir -p "$PLUG_DIR"

    test -d "${PLUG_DIR}/plug.kak" ||
        git clone "$REPO" "${PLUG_DIR}/plug.kak"
}

source %sh{ echo "${HOME}/.cache/kakoune_plugins/plug.kak/rc/plug.kak" }

plug "robertmeta/plug.kak" noload config %{
    # Auto install every pluging
    set-option global plug_always_ensure true
    set-option global plug_install_dir %sh{ echo "${HOME}/.cache/kakoune_plugins" }
}

plug 'alexherbo2/prelude.kak'
plug 'alexherbo2/auto-pairs.kak' config %{
    require-module 'prelude'
    require-module 'auto-pairs'
    auto-pairs-enable
}

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'
plug 'insipx/kak-crosshairs' config %{
    cursorline
}

plug 'kak-lsp/kak-lsp' config %{
    # LSP
    lsp-auto-hover-enable
    set global lsp_hover_max_lines 10
    lsp-inlay-diagnostics-enable global
}

