" {{@@ header() @@}}
" LEL
"             _
"  _ ____   _(_)_ __ ___
" | '_ \ \ / / | '_ ` _ \
" | | | \ V /| | | | | | |
" |_| |_|\_/ |_|_| |_| |_|

" Plugins{{{
"
    " Install plug if it isn't already
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        augroup PLUG
            au!
            autocmd VimEnter * PlugInstall
        augroup END
    endif

    call plug#begin('~/.config/nvim/plugged')


    Plug 'airblade/vim-gitgutter'
    Plug 'chrisbra/Colorizer'


    " Language server support
    "
{%@@ set lsp = "vim-lsp" @@%}

{%@@ if lsp == "vim-lsp" @@%}
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'

    Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        Plug 'prabirshrestha/asyncomplete-file.vim'
{%@@ elif lsp == "coc" @@%}
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
{%@@ endif @@%}

    Plug 'sheerun/vim-polyglot'

    " Plug 'autozimu/LanguageClient-neovim', {
    "     \ 'branch': 'next',
    "     \ 'do': 'bash install.sh',
    "     \}

    " Debugger
    " Plug 'vim-vdebug/vdebug'

    " Fuzzy find
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'

    " Completions
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " HTML shortcuts
    Plug 'mattn/emmet-vim'

    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'junegunn/vim-easy-align'
    Plug 'tpope/vim-commentary'

    " Status bar
    Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
{%@@ if lsp == "ale" @@%}
    let g:airline#extensions#ale#enabled = 1
{%@@ endif @@%}

    " Bufferlist (integrates with airline)
    " Plug 'bling/vim-bufferline'

    " Color scheme
    Plug 'dikiaap/minimalist'
    " Plug 'morhetz/gruvbox' " Not that good

    " Utilities
    "Plug 'xolox/vim-misc'

    " Notes
    "Plug 'xolox/vim-notes'

    " Latex
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    Plug 'vim-scripts/AnsiEsc.vim', { 'for': 'man' }
     " Plug 'powerman/vim-plugin-AnsiEsc'

    " Language sytax highlight improvements
    " Plug 'mboughaba/i3config.vim'
    " Plug 'dag/vim-fish'
    " Plug 'arrufat/vala.vim'
    " Plug 'NLKNguyen/c-syntax.vim'
    " Plug 'vim-python/python-syntax'
    " Plug 'stephpy/vim-yaml'

call plug#end()

"}}}
" Syntax options{{{
"

    " Enable syntax and set color scheme
    syntax on

    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab

    set virtualedit=all

    set scrolloff=10
    set sidescrolloff=10

    set nowrap

    "destaque no númer de linhas
    set number
    set relativenumber

    "display whitespace
    set listchars=tab:>-,trail:~,extends:>,precedes:<
    set listchars=space:_,eol:;,tab:>-,trail:~,extends:>,precedes:<
    set list

    "ativa o mouse
    set mouse =a
    set clipboard +=unnamedplus
    set title

     let g:python_highlight_all = 1
"}}}
" Gay colors{{{

    " if (empty($TMUX))
      if (has('nvim'))
        let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
      endif
      if (has('termguicolors'))
       set termguicolors
      endif
    " endif

    colorscheme minimalist

    set       background=dark

    "background color is transparent
    highlight Normal      guibg=None
    highlight EndOfBuffer guibg=None guifg={{@@ color.bg_light @@}}
    highlight SpecialKey  guibg=None guifg={{@@ color.accent @@}}


    highlight SignColumn      guibg=None
    highlight GitGutterAdd    guifg=lightgreen
    highlight GitGutterChange guifg=yellow
    highlight GitGutterDelete guifg=lightred

    "Line numers
    highlight LineNr  term=bold        ctermfg=9     guifg={{@@ color.bg_light @@}} guibg=None

    "Make whitespace dark
    highlight NonText ctermfg=darkgray guifg={{@@ color.nontxt @@}} guibg=None
    " highlight SpecialKey  ctermfg=black guifg=#252525 guibg=None

    "Current line
    set       cursorline
    highlight CursorLine   term=bold cterm=bold gui=Bold guibg={{@@ color.bg_dark @@}}
    highlight CursorLineNr term=bold cterm=bold gui=Bold guibg={{@@ color.bg_dark @@}} guifg=white

    "Splits
    highlight   VertSplit guibg=None guifg={{@@ color.bg_dark @@}}
    " set         fillchars=vert:/

    highlight Identifier guifg={{@@ color.accent @@}}

    "}}}
" Keys{{{
"

    " Basic motion
    noremap {{@@ key.left  @@}} <left>
    noremap {{@@ key.down  @@}} <down>
    noremap {{@@ key.up    @@}} <up>
    noremap {{@@ key.right @@}} <right>

    noremap <C-w>{{@@ key.left  @@}} :wincmd h<CR>
    noremap <C-w>{{@@ key.down  @@}} :wincmd j<CR>
    noremap <C-w>{{@@ key.up    @@}} :wincmd k<CR>
    noremap <C-w>{{@@ key.right @@}} :wincmd l<CR>

    noremap {{@@ key.next         @@}} n
    noremap {{@@ key.next.upper() @@}} N
    " Added benefits
    noremap - $
    noremap _ ^
    " noremap N <C-w><C-w>
    " noremap T <C-w><C-r>
    noremap H 8<Down>
    noremap T 8<Up>
    " noremap D <C-w><C-r>

    " Single charater traversal
    imap <C-{{@@ key.down  @@}}> <Left>
    imap <C-{{@@ key.up    @@}}> <Right>

    "I deserve the death sentence
    nmap <C-s>      :wa<CR>

    "open and close folds
    nmap    <silent> {{@@ key.right @@}} <right>
    noremap <silent> <right>             <right>:silent! foldopen<CR>

    " Easy comment toggle
    nmap     <silent> gc        :Commentary<CR>
    xmap     <silent> gc        :Commentary<CR>

    " Toggle file manager
    " map      <silent> <C-n> :NERDTreeToggle %:p:h<CR>

    " EasyAlign
    xmap     ga <Plug>(EasyAlign)
    nmap     ga <Plug>(EasyAlign)

    "EasyMotion
    " map e <Plug>(easymotion-prefix)
    set ignorecase

    map <C-j>   :GFiles<CR>
    map <C-q>   :Files<CR>

"}}}
" Lanugage Server{{{
"
    set foldmethod=marker
    set hidden
    set autoread

    autocmd BufWritePre  * :call <SID>StripTrailingWhitespaces()
    function! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun

    " Allow saving of files as sudo when I forgot to start vim using sudo.
    cmap w!! w !sudo tee % >/dev/null

    " Auto deploy dotfiles
    autocmd BufWritePost /**/dotdrop/{config.yaml,dotfiles/**} silent !dotdrop install -f

    {%@@ if     lsp == "vim-lsp" @@%}
" vim-lsp{{{

    "allow json comments
    autocmd FileType json syntax match Comment +\/\/.\+$+

    " Workaround for bug
    let g:lsp_documentation_float=0

    " Complete
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    " Fix
    nmap <silent> gf <Plug>(lsp-document-format)
    vmap <silent> gf <Plug>(lsp-document-range-format)
    nmap          gr :LspRename<cr>

    " Move around
    nmap <silent> [g <Plug>(lsp-previous-diagnostic)
    nmap <silent> ]g <Plug>(lsp-next-diagnostic)

    nmap  <silent> gd :LspDefinition<cr>
    nmap  <silent> K  :LspHover<cr>


    " Colors
    highlight LspErrorHighlight gui=undercurl guisp=red
    highlight LspErrorText      guibg=none    guifg=red gui=underline

    highlight LspWarningHighlight gui=undercurl guisp={{@@ color.normal.yellow @@}}
    highlight LspWarningText      gui=underline guifg={{@@ color.normal.yellow @@}} guibg=none

"}}}
    {%@@ elif   lsp == "coc" @@%}
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
    {%@@ elif   lsp == "ale" @@%}
    " ale{{{

        " Lint
        let g:ale_echo_msg_error_str = 'E'
        let g:ale_echo_msg_warning_str = 'W'
        let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'       "


        let g:ale_python_pyls_executable = '/usr/bin/pyls'
        let g:ale_use_global_executables = 1
        let g:ale_python_mypy_options = '--ignore-missing-imports'
        let g:ale_linters = {
            \ 'python': ['pyls'],
            \ }

        " Fix
        "
        let g:ale_fixers = {
        \   '*': ['remove_trailing_lines', 'trim_whitespace'],
        \   'python': ['autopep8'],
        \}
        let g:ale_fix_on_save = 1

        " Complete
        "
        " Use deoplete.
        let g:deoplete#enable_at_startup = 1
        call deoplete#custom#option('sources', {
            \ '_': ['ale'],
            \})

        " let g:ale_completion_symbols = {
        " \ 'text': '',
        " \ 'method': '',
        " \ 'function': '',
        " \ 'constructor': '',
        " \ 'field': '',
        " \ 'variable': '',
        " \ 'class': '',
        " \ 'interface': '',
        " \ 'module': '',
        " \ 'property': '',
        " \ 'unit': 'unit',
        " \ 'value': 'val',
        " \ 'enum': '',
        " \ 'keyword': 'keyword',
        " \ 'snippet': '',
        " \ 'color': 'color',
        " \ 'file': '',
        " \ 'reference': 'ref',
        " \ 'folder': '',
        " \ 'enum member': '',
        " \ 'constant': '',
        " \ 'struct': '',
        " \ 'event': 'event',
        " \ 'operator': '',
        " \ 'type_parameter': 'type param',
        " \ '<default>': 'v'
        " \ }

        " Move
        "
        " move around
        nmap <silent> [g <Plug>(ale_previous_wrap)
        nmap <silent> ]g <Plug>(ale_next_wrap)

        " Colors
        highlight ALEError       gui=undercurl guisp=red
        highlight ALEErrorSign   guifg=red

        highlight ALEWarning       gui=undercurl guisp=yellow
        highlight ALEWarningSign   guifg=yellow

        "}}}
    {%@@ endif @@%}

"python env{{{
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python'
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
