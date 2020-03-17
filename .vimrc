filetype indent on
filetype plugin on
syntax enable
set nobackup
set ruler
set title
set incsearch
set ignorecase
set smartcase
set cindent
set smartindent
set autoindent
set scrolloff=2
set wildmode=longest,list
set tabstop=3
set shiftwidth=3
set expandtab
set fileencodings=utf-8
set encoding=utf-8
:hi Comment ctermfg=yellow
:hi Directory ctermfg=yellow
highlight! link DiffText MatchParen

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'

" Plugins for `vim-airline`
Plug 'jreybert/vimagit'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
