" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }

" }

" Vundle {
    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
" }

"Bundles {
    " let Vundle manage Vundle, required
    Bundle 'gmarik/vundle'

    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'scrooloose/nerdtree'
    " NERDTree {
        map <leader>z :NERDTreeToggle<CR>
        "Sync up the current file with NERDTree
        map <leader>s :NERDTreeFind<CR>
        let NERDTreeShowBookmarks=1
        let NERDTreeChDirMode=2
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '.DS_Store']
    " }
    Bundle 'tomtom/tcomment_vim'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'kien/ctrlp.vim'
    " ctrlp {
          let g:ctrlp_root_markers = ['*.cabal'] " denote project root
          let g:ctrlp_working_path_mode = 'ra'
          let g:ctrlp_custom_ignore = {
              \ 'dir':  '\v[\/]\.(git|hg|svn)$|dist',
              \ 'file': '\v\.(exe|so|dll)$',
              \ 'link': 'some_bad_symbolic_links',
              \ }
    "}

    Bundle 'jiangmiao/auto-pairs'
    "autopair keybinding in terminal
    if has("gui_macvim")
        let g:AutoPairsShortcutToggle     = 'π' " <m-p>
        let g:AutoPairsShortcutFastWrap   = '∑' " <m-w>
        let g:AutoPairsShortcutJump       = '∆' " <m-j>
        let g:AutoPairsShortcutBackInsert = '∫' " <m-b>
    endif
    Bundle 'rking/ag.vim'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'plasticboy/vim-markdown'
    " indent script tag inside html correctly
    Bundle 'vim-scripts/JavaScript-Indent'

    " python
    Bundle 'klen/python-mode'
    let g:pymode_lint_on_write = 0
    let g:pymode_folding = 0
    let g:pymode_lint_ignore = ""
    let g:pymode_lint_checkers = ['pep8']
    let g:pymode_rope = 0
    "auto format using autopep
    "autocmd FileType python autocmd BufWritePre <buffer> :call pymode#lint#auto()
    autocmd FileType python nnoremap <buffer> <leader>f :PymodeLintAuto<CR>

    " scala
    Bundle 'derekwyatt/vim-scala'
    " sbt filetype
    Bundle 'derekwyatt/vim-sbt'

    "snippets
    Bundle 'SirVer/ultisnips'
    "let g:UltiSnipsUsePythonVersion = 2
    let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
    let g:UltiSnipsEditSplit="horizontal"
    cabbrev es UltiSnipsEdit

    " perl
    " Bundle 'perl-support.vim'

    " html and js
    "Bundle 'Chiel92/vim-autoformat'
    "Bundle 'einars/js-beautify'
    "Bundle "pangloss/vim-javascript"

    "tabular
    Bundle 'godlygeek/tabular'
    if exists(":Tabularize")
        nmap <Leader>a= :Tabularize / = <CR>
        vmap <Leader>a= :Tabularize / = <CR>
    endif

    "Bundle 'Shougo/neocomplcache'

    Bundle 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>

    Bundle 'bitc/lushtags'

    " haskell
    Bundle "Shougo/vimproc.vim"

    Bundle "eagletmt/ghcmod-vim"
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    autocmd FileType haskell nnoremap <buffer> <leader>t :GhcModType<CR>

    Bundle "dag/vim2hs"
    let g:haskell_conceal=0
    let g:haskell_conceal_enumerations=0

    Bundle "nathanaelkane/vim-indent-guides"
    " indent_guides {
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " external haskell formatter
    au BufEnter *.hs setl formatprg=pretty-hs\ --stdin\ --stdout
    " aligns imports and convert tabs into spaces using stylish-haskell
    autocmd FileType haskell nnoremap <buffer> <leader>f :%!stylish-haskell<CR>

    Bundle "bling/vim-airline"
    " vim-airline {
        " Default in terminal vim is 'dark'
        if !exists('g:airline_theme')
            let g:airline_theme = 'solarized'
        endif
        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
    " }

    "Bundle "benmills/vimux"

"}
" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set guioptions-=m           " Remove the menu
        set lines=40                " 40 lines of text instead of 24
        set background=dark
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
            "set macmeta
        elseif WINDOWS() && has("gui_running")
            set guifont=Sauce\ Code\ Powerline:h12:w7
            ",Inconsolata-dz_for_Powerline:h12
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
        set background=light
    endif

" General {
                              " if !has('gui')
                              " set term=$TERM                     " Make arrow and other keys work
                              " endif
    filetype plugin indent on " Automatically detect file types, as in Vundle's doc, this line is below bundles definitions
    syntax on                 " Syntax highlighting
    set mouse=a               " Automatically enable mouse usage
    set mousehide             " Hide the mouse cursor while typing
    scriptencoding utf-8
    set encoding=utf-8

    " if has('clipboard')
    "     if LINUX()   " On Linux use + register for copy-paste
    "         set clipboard=unnamedplus
    "     else         " On mac and Windows, use * register for copy-paste
    "         set clipboard=unnamed
    "     endif
    " endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
" }

" Vim UI {

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    let g:CSApprox_hook_post = ['hi clear SignColumn']
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    " set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set nofoldenable                " disable folding
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    "set foldenable                  " Auto fold code
    "set list
    "set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }
" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType python,haskell,scala,vim,sh autocmd BufWritePre <buffer> :call StripTrailingWhitespace()

    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd BufNewFile,BufRead *.hs setlocal cursorcolumn
    autocmd BufNewFile,BufRead *.cabal setlocal cursorcolumn
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell

" }

" Functions {

 " Strip whitespace {
    function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
    " do the business:
            %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endfunction
    " }
" Mapping {
    cabbrev er e $MYVIMRC
    cabbrev sr so $MYVIMRC
    " Easier moving in tabs and windows
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_
    " Easier horizontal scrolling
    map zl zL
    map zh zH
" }
