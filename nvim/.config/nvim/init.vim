"
" Plugins
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

    Plug 'junegunn/vim-easy-align'

    " Language server support
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \}

    " Fuzzy find
    Plug 'junegunn/fzf'

    " Completions
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " Comments
    Plug 'tpope/vim-commentary'

    " Status bar
    "Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'

    " Bufferlist (integrates with airline)
    "Plug 'bling/vim-bufferline'

    " Color scheme
    Plug 'dikiaap/minimalist'

    " Language support
    Plug 'sheerun/vim-polyglot'
    " Plug 'dense-analysis/ale'
    " Plug 'davidhalter/jedi-vim'

    " Simplify movement
    "Plug 'easymotion/vim-easymotion'

    " Simplify file management
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " Format using prettier
    " Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " Make markdown fun again
    "Plug 'junegunn/limelight.vim'

    " Better buffer management
    "Plug 'qpkorr/vim-bufkill'

    " Utilities
    "Plug 'xolox/vim-misc'

    " Notes
    "Plug 'xolox/vim-notes'
call plug#end()

"
" Syntax options
"

    " Enable syntax and set color scheme
    syntax on


    set tabstop=4
    set shiftwidth=4
    set expandtab
    set smarttab
    set virtualedit=block

    "destaque no númer de linhas
    set number
    set relativenumber

    "display whitespace
    set listchars=tab:>-,trail:~,extends:>,precedes:<
    set listchars=space:_,eol:;,tab:>-,trail:~,extends:>,precedes:<
    "set list

    "ativa o mouse
    set mouse =a
    set clipboard +=unnamedplus
    set title

    "
    " Gay colors
    "
    if (empty($TMUX))
      if (has('nvim'))
        let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
      endif
      if (has('termguicolors'))
       set termguicolors
      endif
    endif

    colorscheme minimalist

    set       background=dark
    "background color is transparent
    highlight Normal      guibg=None
    highlight EndOfBuffer guibg=None
    highlight SpecialKey  guibg=None guifg=#cc5757
    "Line numers
    highlight LineNr      term=bold     ctermfg=9 guifg=#cc5757 guibg=None
    "Make whitespace is dark
    highlight NonText     ctermfg=black guifg=#303030
    highlight SpecialKey  ctermfg=black guifg=#303030

    "Current line
    set cursorline
    highlight CursorLine   term=bold      cterm=bold gui=Bold guibg=#303030
    highlight CursorLineNr term=bold      cterm=bold gui=Bold guibg=None guifg=white


"
" Keys
"

    " Easy comment toggle
    nmap     <silent> gc        :Commentary<CR>
    xmap     <silent> gc        :Commentary<CR>

    " Toggle file manager
    map      <silent> <C-n> :NERDTreeToggle %:p:h<CR>

    " EasyAlign
    xmap     ga <Plug>(EasyAlign)
    nmap     ga <Plug>(EasyAlign)

    " Simplify window navigation
    nnoremap <silent> <C-h> <C-w><C-h>
    nnoremap <silent> <C-j> <C-w><C-j>
    nnoremap <silent> <C-k> <C-w><C-k>
    nnoremap <silent> <C-l> <C-w><C-l>

    " Interact with language server
    map      <silent> <C-Space> :call LanguageClient_contextMenu()<CR>
    nnoremap <silent> gh        :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd        :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> gr        :call LanguageClient#textDocument_references()<CR>
    nnoremap <silent> gs        :call LanguageClient#textDocument_documentSymbol()<CR>
    nnoremap <silent> gR        :call LanguageClient#textDocument_rename()<CR>

"
" Lanugage Server
"


    " " Set this variable to 1 to fix files when you save them.
    " let g:ale_fix_on_save = 1
    " let g:ale_linters = {
    " \   'python': ['pyls'],
    " \}
    " let g:ale_fixers = {
    " \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    " \   'javascript': ['prettier', 'eslint'],
    " \   'python': ['black'],
    " \}

    set hidden
    let g:LanguageClient_serverCommands = {
        \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
        \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
        \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
        \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
        \ 'python': ['/usr/bin/pyls'],
        \ }

    let g:deoplete#enable_at_startup = 1
    " Configure deoplete to use language server
    call deoplete#custom#source('LanguageClient',
        \ 'min_pattern_length',
        \ 2)

"python env
" MUST NOT BE INDENTED!
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
