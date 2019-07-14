if has('win32')
    set encoding=cp932
else
    set encoding=utf-8
endif
scriptencoding utf-8

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

set noswapfile
set nowrap
set visualbell
set expandtab
set tabstop=8
set hlsearch
set fdc=3
set modeline
set modelines=5
set virtualedit=block
set splitright
set history=5000
set laststatus=2
set mouse=

" detail in :help cinoptions-values
set shiftwidth=4
set cindent
set cinoptions+=:0
set cinoptions+=l1
set cinoptions+=g0

if has('persistent_undo')
    set undodir=~/.vim/undo
    set undofile
endif

if &diff
    colorscheme pablo
endif

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deol.nvim')
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
" TODO: https://github.com/Shougo/neosnippet.vim#configuration
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/syntastic')
  call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})
  call dein#add('altercation/vim-colors-solarized')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
"End dein Scripts-------------------------

let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
set t_Co=256
colorscheme solarized
cmap w!! w !sudo tee > /dev/null %
command Ub Unite buffer
let g:deoplete#enable_at_startup = 1
