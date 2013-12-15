set nocompatible               " be iMproved
filetype off                   " required!

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
" Easier horizontal scrolling
map zl zL
map zh zH

" vundle settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'rking/ag.vim'

let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(class|jar|exe|so|dll|png|zip|gz|tar|)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }
" wildignore
" Linux/MacOSX
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip 
" Windows
set wildignore+=*\\tmp\\*,*\\target\\*,*.swp,*.zip,*.exe,*.png,*.jpg
let g:ctrlp_root_markers = ['*.sbt','project']
let g:ctrlp_working_path_mode = 'ra'

" indent script tag inside html correctly
Bundle 'vim-scripts/JavaScript-Indent'

" python
Bundle 'klen/python-mode'
Bundle 'python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'
" disable pymode auto folding
let g:pymode_folding = 0

" scala
Bundle 'derekwyatt/vim-scala'
" sbt filetype
Bundle 'derekwyatt/vim-sbt'

"snippets
Bundle 'SirVer/ultisnips'
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsSnippetsDir="~/.vim/bundle/ultisnips/UltiSnips"

" perl
" Bundle 'perl-support.vim'
" filetype plugin indent on     " required!

" html and js
"Bundle 'Chiel92/vim-autoformat'
"Bundle 'einars/js-beautify'
"Bundle "pangloss/vim-javascript"

" haskell
Bundle 'lukerandall/haskellmode-vim'
" GUI Settings 
" GVIM- (here instead of .gvimrc)
if has('gui_running')
	set guioptions-=T           " remove the toolbar
	set lines=30                " 40 lines of text instead of 24,
	if has("gui_gtk2")
		set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
	else
		set guifont=Consolas:h11
	endif
	if has('gui_macvim')
		set transparency=5          " Make the window slightly transparent
	endif
else
	if &term == 'xterm' || &term == 'screen'
		set t_Co=256                 " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
	endif
	"set term=builtin_ansi       " Make arrow and other keys work
endif

color solarized " color setting after bundle initialized
syntax on
filetype plugin indent on
set nowrap
scriptencoding utf-8
set encoding=utf-8
set backspace=2 " make backspace work like most other apps
set shiftwidth=2
" make tab in Haskell 2 spaces wide
set smarttab
set autoread 
"solve git can't hanle single quote on path problem, seems only works if you enter manually
"set noshellslash

"au BufEnter *.scala setl formatprg=D:\repo\ivy\cache\org.scalariform\scalariform_2.10\jars\scalariform_2.10-0.1.4.jar\ --stdin\ --stdout
