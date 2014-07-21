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
            set shell=/bin/bash
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
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
" }

"Bundles {
    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'scrooloose/nerdtree'
    " NERDTree {
        map <leader>z :NERDTreeToggle<CR>
        "Sync up the current file with NERDTree
        map <leader>s :NERDTreeFind<CR>
        let NERDTreeShowBookmarks=1
        let NERDTreeChDirMode=2
        "let NERDTreeQuitOnOpen=1 "auto close NERDTree after open a file
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '.DS_Store', '.sock', 'dist']
    " }
    Plugin 'tomtom/tcomment_vim'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'kien/ctrlp.vim'
    " ctrlp {
          let g:ctrlp_root_markers = ['build.sbt', '*.cabal'] " denote project root
          let g:ctrlp_working_path_mode = 'ra'
          let g:ctrlp_custom_ignore = {
              \ 'dir':  '\v[\/]\.(git|hg|svn)$|target|dist',
              \ 'file': '\v\.(exe|so|dll)$',
              \ 'link': 'some_bad_symbolic_links',
              \ }
    "}

    Plugin 'jiangmiao/auto-pairs'
    Plugin 'rking/ag.vim'
    Plugin 'tpope/vim-surround'

    Plugin 'plasticboy/vim-markdown'
    let g:vim_markdown_folding_disabled=1

    " python
    Plugin 'klen/python-mode'
    let g:pymode_lint_on_write = 0
    let g:pymode_folding = 0
    let g:pymode_lint_ignore = ""
    let g:pymode_lint_checkers = ['pep8']
    let g:pymode_rope = 0
    "auto format using autopep
    autocmd FileType python nnoremap <buffer> <leader>f :PymodeLintAuto<CR>

    " scala
    Plugin 'derekwyatt/vim-scala'
    " sbt filetype
    Plugin 'derekwyatt/vim-sbt'
    au BufEnter *.scala setl formatprg=java\ -jar\ ~/bin/scalariform.jar\ --stdin\ --stdout

    "snippets
    Plugin 'SirVer/ultisnips'
    "let g:UltiSnipsUsePythonVersion = 2
    let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
    let g:UltiSnipsEditSplit="horizontal"
    cabbrev es UltiSnipsEdit

    "tabular
    Plugin 'godlygeek/tabular'
    " if exists(":Tabularize")
    "     nmap <Leader>a= :Tabularize / = <CR>
    "     vmap <Leader>a= :Tabularize / = <CR>
    "     vmap <Leader>a- :Tabularize / -- <CR>
    "     AddTabularPattern! align_type /\(^[^:]*\zs\(::\)\)\|^\s*\zs\(->\)/l1l1
    "     vmap <Leader>at :Tabularize align_type<CR>
    " endif

    "Plugin 'Shougo/neocomplcache'

    Plugin 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>

    Plugin 'bitc/lushtags'

    Plugin 'Shougo/vimproc.vim'

    " haskell
    Plugin 'eagletmt/ghcmod-vim'
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    autocmd FileType haskell nnoremap <buffer> <F1> :GhcModType<CR>
    autocmd FileType haskell nnoremap <buffer> <F2> :GhcModTypeClear<CR>

    Plugin 'dag/vim2hs'
    let g:haskell_conceal=0
    let g:haskell_conceal_enumerations=0

    Plugin 'nathanaelkane/vim-indent-guides'
    " indent_guides {
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " external haskell formatter
    au BufEnter *.hs setl formatprg=pretty-hs\ --stdin\ --stdout
    " aligns imports and convert tabs into spaces using stylish-haskell
    autocmd FileType haskell nnoremap <buffer> <leader>f :%!stylish-haskell<CR>


    Plugin 'bling/vim-airline'
    " vim-airline {
        " Default in terminal vim is 'dark'
        if !exists('g:airline_theme')
            let g:airline_theme = 'solarized'
        endif
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
        let g:airline_powerline_fonts = 1
    " }

    Plugin 'vim-scripts/bufkill.vim'

    call vundle#end()            " required
"}
" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T                " Remove the toolbar
        set guioptions-=m                " Remove the menu
        set guioptions-=L                " Remove left scrollbar
        set guioptions-=r                " Remove right scrollbar
        set lines=40                     " 40 lines of text instead of 24
        set background=dark
        autocmd GUIEnter * set vb t_vb=  " Disable visual bell
        if LINUX()
            set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        elseif OSX()
            set guifont=Inconsolata\ for\ Powerline:h16,Source\ Code\ Pro\ for\ Powerline:h16
            set macmeta " doesn't work in terminal
        elseif WINDOWS()
            set guifont=Source\ Code\ Pro\ Light:h11
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
    set hidden                " buffer navigation without saving

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
    set noswapfile                      "let Vim trigger file event
    " don't show quickfix in buffers list, set number in quickfix list
    autocmd FileType qf setlocal nobuflisted number nornu
    " disable omni for perl
    autocmd FileType perl set complete-=i

    autocmd BufRead,BufNewFile *.pl,*.plx,*.pm command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy -q
    autocmd BufRead,BufNewFile *.pl,*.plx,*.pm noremap <Leader>f :Tidy<CR>
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
    function! FormatRoute()
       % Tabularize /^[^\/]*\zs\/.*/l5
       % Tabularize /controllers.*/l10
    endfunction

    function! CopyMatches(reg)
      let hits = []
      %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
      let reg = empty(a:reg) ? '+' : a:reg
      execute 'let @'.reg.' = join(hits, "\n") . "\n"'
    endfunction
    command! -register CopyMatches call CopyMatches(<q-reg>)

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
    map <C-J> <C-W><C-J>
    map <C-K> <C-W><C-K>
    map <C-L> <C-W><C-L>
    map <C-H> <C-W><C-H>
    " Easier horizontal scrolling
    map zl zL
    map zh zH
    " cycling buffer
    nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
    nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

    " resizing split
    nnoremap <silent> <C-Right> :exe "vertical resize +5" <CR>
    nnoremap <silent> <C-Left> :exe "vertical resize -5" <CR>
    nnoremap <silent> <C-Up> :exe "resize -5" <CR>
    nnoremap <silent> <C-Down> :exe "resize +5" <CR>
    " ctrl s save
    noremap <silent> <C-S> :update<CR>
    vnoremap <silent> <C-S> <C-C>:update<CR>
    inoremap <silent> <C-S> <C-O>:update<CR>
" }
