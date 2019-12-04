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
    " https://github.com/neovim/neovim/wiki/Following-HEAD#20181118
    call dein#add('roxma/vim-hug-neovim-rpc', {'build': 'sudo pip3 install pynvim && pip3 install --user pynvim'})
  endif
" TODO: https://github.com/Shougo/neosnippet.vim#configuration
  call dein#add('Shougo/neosnippet')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/syntastic')
  call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'})
  call dein#add('altercation/vim-colors-solarized')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
"End dein Scripts-------------------------

"  `pip install --user python-language-server`
if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
let g:solarized_termcolors=256
let g:solarized_termtrans=1
set background=dark
set t_Co=256
colorscheme solarized
cmap w!! w !sudo tee > /dev/null %
let g:deoplete#enable_at_startup = 1
command UB Unite buffer
command Ub Unite buffer
command LD LspDefinition
