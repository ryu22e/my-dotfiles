set nocompatible
filetype off

if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle.git/ 
  call vundle#rc('~/vimfiles/bundle/')
else
    set rtp+=~/.vim/vundle/
    call vundle#rc()
endif

syntax on
set laststatus=2
set number
set autoindent
set expandtab
set ignorecase
set wildmenu
set showmatch
set shiftwidth=4
set smarttab
set tabstop=4
set softtabstop=4
set showtabline=2
setlocal omnifunc=syntaxcomplete#Complete
set list
set listchars=tab:>\ ,extends:<
set smartcase
set smartindent
set textwidth=0
set backspace=indent,eol,start
set ruler
highlight zenkakuda ctermbg=7
match zenkakuda /　/
filetype plugin indent on

Bundle 'gmarik/vundle'
Bundle 'git-commit'
Bundle 'quickrun.vim'
Bundle 'cake.vim'
Bundle 'Gist.vim'
Bundle 'PHP-dictionary'
Bundle 'Pydiction'
Bundle 'YankRing.vim'
Bundle 'matchit.zip'

Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/unite.vim'

Bundle 'Lokaltog/vim-powerline'

"encoding
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos

" git-commit.vim
let git_diff_spawn_mode = 1

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" template
:autocmd BufNewFile  *.pl      0r ~/.vim/template/skeleton.pl
:autocmd BufNewFile  *.py      0r ~/.vim/template/skeleton.py
:autocmd BufNewFile  *.html      0r ~/.vim/template/skeleton.html
:autocmd BufNewFile *.user.js   0r ~/.vim/template/skeleton.user.js
:autocmd BufNewFile *.php   0r ~/.vim/template/skeleton.php

" For Windows IME
inoremap <silent> <ESC> <ESC>
inoremap <silent> <C-[> <ESC>

" Key for fixed mode
inoremap <silent> <C-j> <C-^>

" Fold
set foldlevel=0
set foldmethod=syntax
let perl_fold=1

" For PHP Fold
let php_folding=1
au Syntax php set fdm=syntax

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 0
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3

" Disable Pydiction in default
let g:pydiction_location=''

" vim-powerline
let g:Powerline_symbols = 'fancy'

" Key for buffers
noremap <C-j> <C-^>

" Move the cursor to the end of the previous line
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" vimgrep
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" incsearch
set incsearch
if has("migemo")
    set migemo
endif

" Select pasted text in visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Edit temporary file
:command! OpenTempfile :edit `=tempname()`

" Insert Date
cnoremap <expr> <C-X>dt strftime('%Y%m%d')

" Insert Time
cnoremap <expr> <C-X>ts strftime('%Y%m%d%H%M')

" YankRing
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'
noremap <silent> <F7> :YRShow<CR>
let g:yankring_max_history = 10
let g:yankring_window_height = 13

" Replace the word under the cursor with the yanked text
nnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

" F5 = Open command history
nnoremap <F5> <Esc>q:
" F6 = Search history
nnoremap <F6> <Esc>q/
" Disable q:
nnoremap q: <Nop>
" Disable q/
nnoremap q/ <Nop>
" Disable q?
nnoremap q? <Nop>

" matchit.vim
runtime macros/matchit.vim
let b:match_words = &matchpairs . "\<if\>:\<end if\>,\<if\>:\<endif\>"
let b:match_ignorecase = 1
