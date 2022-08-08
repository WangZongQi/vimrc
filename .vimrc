set nocompatible
set shortmess=atI
"set mouse=a

if (has("win32") || has("win95") || has("win64") || has("win16"))
	"maximum the initial window
	au GUIEnter * simalt ~x
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()

	set guifont=Consolas:h12
elseif (has("mac"))
	"set fu
	set guifont=Monaco:h14
else 
	set guifont=Monospace\ 12
endif

set laststatus=2

" No toolbar
set guioptions-=T

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

" git clone https://github.com/VundleVim/Vundle.vim.git
" set the runtime path to include Vundle and initialize
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.Vim/bundle/Vundle.vim/ 
call vundle#begin('~/.Vim/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'jlanzarotta/bufexplorer.git'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mbbill/fencview.git'
Plugin 'vim-scripts/gtags.vim.git'
Plugin 'tmhedberg/matchit.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline.git'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'easymotion/vim-easymotion.git'
Plugin 'terryma/vim-expand-region.git'
Plugin 'sickill/vim-monokai'
Plugin 'kshenoy/vim-signature.git'
Plugin 'google/vim-searchindex'
Plugin 'rhysd/clever-f.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplete.vim'
"Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-surround'
"Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'pboettch/vim-cmake-syntax'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'luochen1990/rainbow'
"Plugin 'thiagoalessio/rainbow_levels.vim'
"Plugin 'python-mode/python-mode'
"Plugin 'davidhalter/jedi-vim'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'rhysd/vim-clang-format'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
"Plugin 'Yggdroot/indentLine'

"Plugin 'Valloric/YouCompleteMe'
"Plugin 'rking/ag.vim'
"Plugin 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set omnifunc=syntaxcomplete#Complete

syntax on

" Rainbow
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

set matchpairs=(:),{:},[:],<:>

" gTags
set cscopetag
set cscopeprg=gtags-cscope
let g:Gtags_OpenQuickfixWindow=0

" Airline
" Do not show message about whitespace
let g:airline#extensions#whitespace#show_message = 0

" CtrlP
let g:ctrlp_working_path_mode = 0

"taglist
"let Tlist_Auto_Update=1
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Show_One_File=1

let g:clang_format#detect_style_file=1

colo monokai

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set nobackup
set noswapfile
set noundofile

set foldmethod=indent
set foldlevelstart=12
nnoremap <space> za
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>p :CtrlP<CR>
nnoremap <F12> <Esc>:GtagsCursor<CR>

set wrap
set number
"set relativenumber
set tabstop=4
set expandtab
set shiftwidth=4
set showcmd
set selection=inclusive

set clipboard=unnamed

set cursorline
set incsearch

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Add GTAGS
let s:gtag_path = "GTAGS"
for i in range(20)
    if filereadable(s:gtag_path)
        cs add s:gtag_path
    endif
    let s:gtag_path = "../".s:gtag_path
endfor

"set encoding=utf-8
"set fileencodings=utf-8,cp936
"set fileencoding=uft-8
"set termencoding=utf-8

"let g:fencview_autodetect=1 
"let g:fencview_auto_patterns='*'
"let g:autofenc_enable=1

set path+=..
set path+=../..
set path+=../../..
set path+=../../../..
set path+=../../../../..
set path+=../../../../../..

function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

augroup filetype
    autocmd! BufRead,BufNewFile BUILD set filetype=blade
augroup end

