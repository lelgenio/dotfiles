" {{@@ header() @@}}
"             _
"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|

" Plugins{{{
"
    " Install plug if it isn't already {{{
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        augroup PLUG
            au!
            autocmd VimEnter * PlugInstall
        augroup END
    endif
    "}}}

call plug#begin('~/.config/nvim/plugged')

    Plug 'chrisbra/Colorizer'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    let g:gitgutter_map_keys = 0

    " Language server support
    "
" {%@@ set lsp = "vim-lsp" @@%}

" {%@@ if lsp == "vim-lsp" @@%} "
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        Plug 'prabirshrestha/asyncomplete-file.vim'
        Plug 'prabirshrestha/asyncomplete-emmet.vim'
        Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
        Plug 'prabirshrestha/asyncomplete-buffer.vim'

    set completeopt+=menu,longest,preview
" {%@@ elif lsp == "coc" @@%} "
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
" {%@@ endif @@%}

    Plug 'sheerun/vim-polyglot'

    " Fuzzy find
    Plug 'junegunn/fzf', { 'do': {-> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " Completions
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " HTML shortcuts
    Plug 'mattn/emmet-vim'

    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-commentary'

    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'

    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'

    " Select based on indentation
    Plug 'lelgenio/vim-indent-object-colemak'

    " Status bar
    " Plug 'vim-airline/vim-airline'

    " Color scheme
    Plug 'dikiaap/minimalist'
    Plug 'endel/vim-github-colorscheme'

    " Latex
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'vim-scripts/AnsiEsc.vim', { 'for': 'man' }

    Plug 'rbgrouleff/bclose.vim'
    Plug 'francoiscabrol/ranger.vim'
    let g:ranger_replace_netrw = 1
    let g:ranger_map_keys = 0

call plug#end()

"}}}
" General{{{
"
    " set foldmethod=marker " Friendship with marker ended, new indent is my best friend
    set smartcase
    set hidden
    set autoread

    " Better completion on command line
    set wildmode=longest:full

    " Show line numbers on the left
    set number
    set relativenumber

    " Avoid shifting the text due to git or LSP
    set signcolumn=yes

    " Auto trimm end of line whitespace
    autocmd BufWritePre  * :call <SID>StripTrailingWhitespaces()
    function! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun

    " Allow saving of files as sudo when I forget to start vim using sudo.
    cmap w!! w !sudo tee % >/dev/null

"}}}
" Syntax options{{{
"

    syntax on

    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab

    set spelllang=en_us,pt_br
    autocmd FileType tex set spell

    " Allow moving the cursor anywhere
    set virtualedit=all

    " When to start scrolling the window
    set scrolloff=8
    set sidescrolloff=8

    set linebreak

    " Display whitespace
    set listchars=space:_,eol:;,tab:>-,trail:~,extends:>,precedes:<
    " {%@@ if color.type != "light" @@%} "
    set list
    " {%@@ endif @@%}

    " Enable mouse
    set mouse =a
    set clipboard +=unnamedplus

    " Rename the terminal
    set title

    let g:python_highlight_all = 1
"}}}
" Gay colors{{{

    if (has('nvim'))
      let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
    endif
    if (has('termguicolors'))
     set termguicolors
    endif

    " {%@@ if color.type == "light" @@%} "
        colorscheme github
        set       background=light
    " {%@@ elif color.type == "dark" @@%} "
        colorscheme minimalist
        set       background=dark
    " {%@@ endif @@%}

    "{%@@ set c = color     @@%}"
    "{%@@ set n = c.normal  @@%}"

    "background color is transparent
    highlight Normal          guibg=None
    highlight EndOfBuffer     guibg=None guifg={{@@ c.bg_light @@}}
    highlight SpecialKey      guibg=None guifg={{@@ accent_color   @@}}
    highlight Folded          guibg=None

    highlight tabLine         None
    highlight tabLineFill     None

    highlight SignColumn      guibg=None
    highlight GitGutterAdd    guibg=None guifg={{@@ n.green @@}}
    highlight GitGutterChange guibg=None guifg={{@@ n.yellow @@}}
    highlight GitGutterDelete guibg=None guifg={{@@ n.red @@}}

    "Line numers
    highlight LineNr  term=bold        ctermfg=9     guifg={{@@ c.bg_light @@}} guibg=None

    " Comments
    highlight Comment guifg={{@@ c.bg_light @@}} guibg=None

    "Make whitespace dark
    highlight NonText guifg={{@@ c.nontxt @@}} guibg=None
    " highlight SpecialKey  ctermfg=black guifg=#252525 guibg=None

    "Current line
    " {%@@ if c.type != "light" @@%} "
    set       cursorline
    highlight CursorLine    term=bold  cterm=bold   gui=Bold      guibg={{@@ c.bg_dark @@}}
    highlight CursorLineNr  term=bold  cterm=bold   gui=Bold      guibg={{@@ c.bg_dark @@}}
    " {%@@ endif @@%} "
    highlight CursorLineNr  guifg={{@@ c.nontxt @@}}

    "Splits
    highlight VertSplit     guibg=None guifg={{@@   c.bg_dark @@}}
    " set         fillchars=vert:/

    highlight Identifier    guifg={{@@ accent_color @@}}

    highlight MatchParen    gui=bold   guifg={{@@ n.yellow @@}}

    highlight SpellBad      guisp={{@@ n.red    @@}} guibg=none
    highlight SpellRare     guisp={{@@ n.blue   @@}} guibg=none
    highlight SpellCap      guisp={{@@ n.cyan   @@}} guibg=none
    highlight SpellLocal    guisp={{@@ n.yellow @@}} guibg=none

    "}}}
" Keys{{{
"
    " The g is for moving between lines broken by wrap.
    {%@@ set keys = {
        " h": key.left,
        "gj": key.down,
        "gk": key.up,
        " l": key.right,
    } @@%}

    " Basic motion
    {%@@ for old, new in keys.items() @@%}
    " {{@@ new @@}} -> {{@@ old @@}}
    noremap {{@@ new @@}} {{@@ old @@}}
    noremap <silent> <C-w>{{@@ new          @@}} :wincmd {{@@ old[-1]         @@}}<CR>
    noremap <silent> <C-w>{{@@ new.upper()  @@}} :wincmd {{@@ old[-1].upper() @@}}<CR>
    {%@@ endfor @@%}


    " Skip 8 lines
    noremap {{@@ key.down.upper() @@}} 8<Down>
    noremap {{@@ key.up.upper()   @@}} 8<Up>

    " Repeat search
    noremap {{@@ key.next         @@}} n
    noremap {{@@ key.next.upper() @@}} N

    " for/backward on tabs
    nnoremap {{@@ key.tabL @@}} :tabprev<cr>
    nnoremap {{@@ key.tabR @@}} :tabnext<cr>

    " Enter insert mode
    noremap {{@@ key.insertMode         @@}} i
    noremap {{@@ key.insertMode.upper() @@}} I

    " Keyboard Layout specific
    " {%@@ if key_layout == "colemak" @@%} "

        " Insert on next line
        noremap h o
        noremap H O

        " Jump to oposite side of selection
        vnoremap m o
        vnoremap M O

        " To end of word
        noremap t e
        noremap T E

        noremap , ^

        imap {{@@ key.insertQuit @@}} <ESC>

        " FZF bindings
        nmap <C-b>      :Buffers<CR>
        nmap <C-k>      :Files  <CR>
        nmap <C-n>      :GFiles <CR>

        " Snippets
        imap <C-e>     <Plug>(neosnippet_expand_or_jump)
        smap <C-e>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-e>     <Plug>(neosnippet_expand_target)

        " Surround
        let g:surround_no_mappings = 1
        nmap dk  <Plug>Dsurround
        nmap ck  <Plug>Csurround
        nmap cK  <Plug>CSurround
        nmap yk  <Plug>Ysurround
        nmap yK  <Plug>YSurround
        nmap ykk <Plug>Yssurround
        nmap yKk <Plug>YSsurround
        nmap yKK <Plug>YSsurround
        xmap K   <Plug>VSurround
        xmap gK  <Plug>VgSurround

    " {%@@ elif key_layout == "dvorak" @@%} "

        " Added benefits
        noremap - $
        noremap _ ^
        noremap N <C-w><C-w>
        noremap T <C-w><C-r>

        " FZF bindings
        nmap <C-j>      :GFiles <CR>
        nmap <C-k>      :Files  <CR>
        nmap <C-b>      :Buffers<CR>

    " {%@@ elif key_layout == "qwerty" @@%} "

        " FZF bindings
        nmap <C-b>      :Buffers<CR>
        nmap <C-n>      :Files  <CR>
        nmap <C-m>      :GFiles <CR>

    " {%@@ endif @@%} "

    " File Browser
    nmap F          :Ranger <CR>

    " Open folds
    nmap <silent> {{@@    key.right       @@}} <right>
    nmap <silent> <right> <right>:silent! foldopen<CR>

    "I deserve the death sentence
    nmap <C-s>      :wa<CR>
    nmap <C-Q>      :wqa<CR>

    " Easy comment toggle
    nmap     <silent> gc        :Commentary<CR>
    xmap     <silent> gc        :Commentary<CR>

    " EasyAlign
    xmap     ga <Plug>(EasyAlign)
    nmap     ga <Plug>(EasyAlign)


    " Custom surrounds, should work fine on all layouts
    "              d
    autocmd FileType * let b:surround_100 = "{{@@ '{{@@ \\r @@}}' @@}}"
    "              s
    autocmd FileType * let b:surround_115 = "{{@@ '#{%@@ \\r @@%}#\\n#{%@@  @@%}#' @@}}"

"}}}
" Lanugage Server{{{
"
    " {%@@ if     lsp == "vim-lsp" @@%} "
" vim-lsp{{{

    "allow json comments
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Workaround for bug
    " let g:lsp_documentation_float = 0

    " Complete
    inoremap <expr>    <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr>    <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr>    <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
    imap     <c-space> <Plug>(asyncomplete_force_refresh)

    " Fix
    nmap gf <Plug>(lsp-document-format)
    vmap gf <Plug>(lsp-document-range-format)
    nmap gr <plug>(lsp-rename)
    nmap gl <plug>(lsp-code-action)
    nmap gs <plug>(lsp-references)

    " Move around
    nmap <silent> [g <Plug>(lsp-previous-diagnostic)
    nmap <silent> ]g <Plug>(lsp-next-diagnostic)

    nmap  <silent> gd :LspDefinition<cr>
    nmap  <silent> K  :LspHover<cr>

    " Lint
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_virtual_text_enabled = 0

    " Colors
    highlight LspErrorHighlight     gui=undercurl guisp={{@@ color.normal.red    @@}}
    highlight LspErrorText          gui=bold      guifg={{@@ color.normal.red    @@}} guibg=none
    highlight LspErrorVirtual       gui=underline guifg={{@@ color.normal.red    @@}} guibg=none

    highlight LspWarningHighlight   gui=undercurl guisp={{@@ color.normal.yellow @@}}
    highlight LspWarningText        gui=bold      guifg={{@@ color.normal.yellow @@}} guibg=none
    highlight LspWarningVirtual     gui=underline guifg={{@@ color.normal.yellow @@}} guibg=none

    " Highlight all references, looks pretty *-*
    let g:lsp_highlight_references_enabled = 1
    highlight LspReference          gui=bold      guifg={{@@ color.normal.yellow @@}}

    " Complete File paths{{{
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
                \ 'name': 'file',
                \ 'whitelist': ['*'],
                \ 'priority': 10,
                \ 'completor': function('asyncomplete#sources#file#completor')
                \ }))
    "}}}
    " Emmet{{{
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emmet#get_source_options({
        \ 'name': 'emmet',
        \ 'whitelist': ['html'],
        \ 'completor': function('asyncomplete#sources#emmet#completor'),
        \ }))
    "}}}
    " Snipets{{{
    call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
                \ 'name': 'neosnippet',
                \ 'whitelist': ['*'],
                \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
                \ }))

    "}}}
    "Buffer{{{
        call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
            \ 'name': 'buffer',
            \ 'allowlist': ['*'],
            \ 'completor': function('asyncomplete#sources#buffer#completor'),
            \ 'config': {
            \    'max_buffer_size': 5000000,
            \  },
            \ }))
    "}}}
"}}}
    " {%@@ elif   lsp == "coc" @@%} "
    "" coc {{{

        "allow json comments
        autocmd FileType json syntax match Comment +\/\/.\+$+

        " Don't pass messages to |ins-completion-menu|.
        set shortmess+=c

        " Always show the signcolumn, otherwise it would shift the text each time
        " diagnostics appear/become resolved.
        if has("patch-8.1.1564")
          " Recently vim can merge signcolumn and number column into one
          set signcolumn=number
        else
          set signcolumn=yes
        endif

        " Use `[g` and `]g` to navigate diagnostics
        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Use gd to show documentation in preview window.
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        function! s:show_documentation()
          if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
          else
            call CocAction('doHover')
          endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " Symbol renaming.
        nmap gr <Plug>(coc-rename)

        " use <tab> for trigger completion and navigate to the next complete item
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~ '\s'
        endfunction

        inoremap <silent><expr> <Tab>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<Tab>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        " Formatting selected code.
        xmap gf  <Plug>(coc-format-selected)
        nmap gf  <Plug>(coc-format-selected)

        " Add `:Format` command to format current buffer.
        command! -nargs=0 Format :call CocAction('format')

        " Map function and class text objects
        " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
        xmap if <Plug>(coc-funcobj-i)
        omap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap af <Plug>(coc-funcobj-a)
        xmap ic <Plug>(coc-classobj-i)
        omap ic <Plug>(coc-classobj-i)
        xmap ac <Plug>(coc-classobj-a)
        omap ac <Plug>(coc-classobj-a)

    "}}}
    " {%@@ endif @@%} "

"python env{{{
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
" MUST NOT BE INDENTED!
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
"}}}
" Latex{{{
    let g:livepreview_previewer = 'zathura'
    autocmd FileType tex LLPStartPreview
"}}}
"groff{{{
augroup filetrype_groff
    autocmd VimEnter        *.ms        set ft=groff

    autocmd VimEnter        *.ms        silent !zathura (string replace --regex .ms\$ .pdf "%" ) & jobs -lp > /tmp/groff-preview
    autocmd VimLeave        *.ms        silent !kill (cat /tmp/groff-preview )

    autocmd BufWritePost    *.ms        silent !compile %

    " autocmd FileType        groff       setlocal commentstring=\\\"\ %s
augroup END
"}}}
"}}}
"Hide statusbar{{{
    let s:hidden_all = 0
    function! ToggleHiddenAll()
        if s:hidden_all  == 0
            let s:hidden_all = 1
            set noshowmode
            set noruler
            set laststatus=0
            set noshowcmd
        else
            let s:hidden_all = 0
            set showmode
            set ruler
            set laststatus=2
            set showcmd
        endif
    endfunction

    " nnoremap <S-h> :call ToggleHiddenAll()<CR>
    call ToggleHiddenAll()
"}}}
" vim:foldmethod=marker
