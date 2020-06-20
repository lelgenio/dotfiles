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

    Plug 'arrufat/vala.vim'
    Plug 'NLKNguyen/c-syntax.vim'
    Plug 'vim-python/python-syntax'
    Plug 'jaxbot/semantic-highlight.vim'
    Plug 'stephpy/vim-yaml'

    Plug 'airblade/vim-gitgutter'
    Plug 'chrisbra/Colorizer'

    Plug 'junegunn/vim-easy-align'

    " Language server support
    "
    " Plug 'sheerun/vim-polyglot'
    " Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'davidhalter/jedi-vim'

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
    Plug 'easymotion/vim-easymotion'

    " Simplify file management
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
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

    " Quickly exit insert mode
    imap jj <ESC>

    "I deserve the death sentence
    nmap <C-s>      :w<CR>

    "open and close folds
    nmap    <silent> {{@@ key.right @@}} <right>
    noremap <silent> <right>             <right>:silent! foldopen<CR>

    " Easy comment toggle
    nmap     <silent> gc        :Commentary<CR>
    xmap     <silent> gc        :Commentary<CR>

    " Toggle file manager
    map      <silent> <C-n> :NERDTreeToggle %:p:h<CR>

    " EasyAlign
    xmap     ga <Plug>(EasyAlign)
    nmap     ga <Plug>(EasyAlign)

    "EasyMotion
    map e <Plug>(easymotion-prefix)
    set ignorecase

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
"}}}
" Lanugage Server{{{
"
    set foldmethod=marker
    set hidden
    set autoread

     function! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun

    autocmd BufWritePre  * :call <SID>StripTrailingWhitespaces()

    " Auto deploy dotfiles
    autocmd BufWritePost /**/dotdrop/{config.yaml,dotfiles/**} silent !dotdrop install -f

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

    " nnoremap <S-h> :call ToggleHiddenAll()<CR>
    call ToggleHiddenAll()
"}}}
" vim:foldmethod=marker
