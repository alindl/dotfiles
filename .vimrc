set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" Clojure REPL stuff (fireplace)
Plugin 'guns/vim-clojure-static.git'
Plugin 'guns/vim-clojure-highlight.git'
Plugin 'tpope/vim-leiningen.git'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-fireplace.git'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'guns/vim-sexp'
Plugin 'guns/vim-slamhound'
Plugin 'dgrnbrg/redl'
" HTML and webprogramming stuff
Plugin 'mattn/emmet-vim.git'
"Plugin 'tpope/vim-surround.git'
Plugin 'valloric/MatchTagAlways.git'
"Plugin 'valloric/YouCompleteMe.git'
Plugin 'jreybert/vimagit'
Plugin 'ap/vim-css-color'
Plugin 'Mizuchi/vim-ranger'
Plugin 'francoiscabrol/ranger.vim'
Plugin 'delimitMate.vim'
" Python virtualenv usage
Plugin 'plytophogy/vim-virtualenv'
Plugin 'PieterjanMontens/vim-pipenv'
" Zettelkasten
" Plugin 'junegunn/fzf.vim'
" Plugin 'fiatjaf/neuron.vim'

"Plugin 'vim-scripts/AutoClose.git'
"Plugin 'Pydiction'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set tabstop=4             " Tabs are 4 spaces long 
set shiftwidth=4          " Shifts are 4 spaces long
set expandtab             " Tabs are spaces
set smartindent           " Be smart about indent
set number relativenumber " Line numbering
set lazyredraw            " redraw only when we need to
set ignorecase            " Ignore case on searches
set showcmd               " Show (partial) command in status line
set showmatch             " Show matching brackets
set smartcase             " Do smart case matching
set incsearch             " Incremental search
set autoindent            " Take indent for new line from previous line
set confirm               " Ask instead of error on quit
set wildmenu              " Better command-line completion

set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


filetype plugin indent on
set grepprg=grep\ -nH\ $*
" Compiler and viewer settings
let g:tex_flavor='latex'  
let g:Tex_BibtexFlavor = 'biber'
let g:Tex_CompileRule_pdf = 'pdflatex --synctex=-1 -src-specials -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf,biblatex,pdf'
let g:Tex_ViewRule_pdf =  'zathura '
" also, this installs to /usr/share/vim/vimfiles, which may not be in
" your runtime path (RTP). Be sure to add it too, e.g:
" set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
