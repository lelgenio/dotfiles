# {{@@ header() @@}}

nop %sh{
    PLUG_DIR="${HOME}/.cache/kakoune_plugins"
    REPO="https://github.com/andreyorst/plug.kak.git"

    mkdir -p "$PLUG_DIR"

    test -d "${PLUG_DIR}/plug.kak" ||
        git clone "$REPO" "${PLUG_DIR}/plug.kak"
}

source %sh{ echo "${HOME}/.cache/kakoune_plugins/plug.kak/rc/plug.kak" }

plug "andreyorst/plug.kak" noload config %{
    # Auto install every pluging
    set-option global plug_always_ensure true
    set-option global plug_install_dir %sh{ echo "${HOME}/.cache/kakoune_plugins" }
}

plug 'eraserhd/kak-ansi'

plug 'alexherbo2/prelude.kak'
plug 'alexherbo2/auto-pairs.kak' commit "fd735ec149ef0d9ca5f628a95b1e52858b5afbdc" config %{
    require-module 'prelude'
    require-module 'auto-pairs'
    auto-pairs-enable
}

plug 'h-youhei/kakoune-surround'

plug 'delapouite/kakoune-palette'
plug 'greenfork/active-window.kak'
plug 'insipx/kak-crosshairs' config %{
    crosshairs
}

# Search and replace, for every buffer
plug 'occivink/kakoune-find'

plug 'kak-lsp/kak-lsp' do %{
    cargo install --features "no-lto" --locked --force --path .
} config %{
    set global lsp_hover_max_lines 10
    # lsp-inlay-diagnostics-enable global
    set global lsp_auto_highlight_references true
    # set global lsp_inlay_diagnostic_sign "●"
    # set global lsp_diagnostic_line_error_sign "●"

    # hook global BufCreate   .* %{try lsp-enable}

    # hook global -group rust-inlay-hints-auto WinSetOption filetype=rust %{
    #     hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
    #     hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
    #     hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
    #     hook -once -always window WinSetOption filetype=.* %{
    #         remove-hooks window rust-inlay-hints
    #     }
    # }

    # define-command -override -hidden lsp-enable-decals %{
    #     lsp-inlay-diagnostics-enable global
    #     try %{
    #         add-highlighter global/rust_analyzer_inlay_hints replace-ranges rust_analyzer_inlay_hints
    #     }
    # }

    # define-command -override -hidden lsp-disable-decals %{
    #     lsp-inlay-diagnostics-disable global
    #     remove-highlighter global/rust_analyzer_inlay_hints
    # }

    # hook global ModeChange '.*:insert:normal' %{lsp-enable-decals}
    # hook global ModeChange '.*:normal:insert' %{lsp-disable-decals}

    hook global WinSetOption filetype=(c|cpp|rust) %{
        lsp-enable
        hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
        hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
        hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
        hook -once -always window WinSetOption filetype=.* %{
            remove-hooks window semantic-tokens
        }
    }
}

