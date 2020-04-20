"
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

    Plug 'junegunn/vim-easy-align'

    " Language server support
    "
    " Plug 'sheerun/vim-polyglot'
    " Plug 'dense-analysis/ale'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'davidhalter/jedi-vim'

    " Plug 'autozimu/LanguageClient-neovim', {
    "     \ 'branch': 'next',
    "     \ 'do': 'bash install.sh',
    "     \}

    " Debugger
    " Plug 'vim-vdebug/vdebug'

    " Fuzzy find
    " Plug 'junegunn/fzf'

    " Completions
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " Pais
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'

    " Comments
    Plug 'tpope/vim-commentary'

    " Status bar
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    " let g:airline#extensions#ale#enabled = 1

    " Bufferlist (integrates with airline)
    "Plug 'bling/vim-bufferline'

    " Color scheme
    Plug 'dikiaap/minimalist'


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

    " Latex
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    Plug 'vim-latex/vim-latex', { 'for': 'tex' }
    Plug 'vim-scripts/AnsiEsc.vim', { 'for': 'man' }
     " Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'mboughaba/i3config.vim'
    Plug 'dag/vim-fish'
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
    set virtualedit=block

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
    highlight EndOfBuffer guibg=None guifg=#303030
    highlight SpecialKey  guibg=None guifg=#cc5757

    "Line numers
    highlight LineNr      term=bold     ctermfg=9 guifg=#cc5757 guibg=None

    "Make whitespace dark
    highlight NonText     ctermfg=darkgray guifg=#252525 guibg=None
    " highlight SpecialKey  ctermfg=black guifg=#252525 guibg=None

    "Current line
    set cursorline
    highlight CursorLine   term=bold      cterm=bold gui=Bold guibg=#191919
    highlight CursorLineNr term=bold      cterm=bold gui=Bold guibg=#191919 guifg=white
"}}}
" Keys{{{
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
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

"}}}
" Lanugage Server{{{
"
    set foldmethod=marker
    set hidden
    " let g:deoplete#enable_at_startup = 1


    " let g:LanguageClient_serverCommands = {
    "     \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    "     \ 'python': ['/usr/bin/pyls'],
    "     \ 'tex': ['/usr/bin/texlab'],
    "     \ 'c': ['cquery', '--log-file=/tmp/cq.log'],
    "     \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
    "     \ }


    " call deoplete#custom#source('LanguageClient',
    "         \ 'min_pattern_length',
    "         \ 2)
    " " Configure deoplete to use language server


    " let g:ale_fix_on_save = 1
    " let g:ale_fixers = {
    "     \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    "     \   'javascript': ['eslint'],
    "     \   'python': ['black'],
    "     \}

"python env{{{
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

    nnoremap <S-h> :call ToggleHiddenAll()<CR>
    call ToggleHiddenAll()
"}}}
" vim:foldmethod=marker
