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
plug 'alexherbo2/auto-pairs.kak' commit "fd735ec149ef0d9ca5f628a95b1e52858b5afbdc" config %{
    require-module 'prelude'
    require-module 'auto-pairs'
    auto-pairs-enable
}

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'
plug 'insipx/kak-crosshairs' config %{
    crosshairs
}

# Search and replace, for every buffer
plug 'occivink/kakoune-find'

plug 'kak-lsp/kak-lsp' config %{
    # LSP
    set global lsp_hover_max_lines 10
    # lsp-inlay-diagnostics-enable global

    hook global BufCreate   .* %{try lsp-enable}
    hook global WinSetOption filetype=(c|cpp|rust|python) %{
        # lsp-auto-hover-enable
        hook buffer NormalIdle  .* %{try lsp-highlight-references}
    }

    hook global WinSetOption filetype=rust %{
        # hook window NormalIdle .* rust-analyzer-inlay-hints
    }


    hook global WinSetOption filetype=(c|cpp|rust) %{
        hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
        hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
        hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
        hook -once -always window WinSetOption filetype=.* %{
            remove-hooks window semantic-tokens
        }
    }

}

