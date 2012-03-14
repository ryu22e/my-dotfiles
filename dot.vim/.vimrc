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
set hlsearch
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
Bundle 'speeddating.vim'
Bundle 'abolish.vim'
Bundle 'Justify'
Bundle 'smartchr'

Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'

Bundle 'Lokaltog/vim-powerline'

Bundle 'ynkdir/vim-funlib'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'

Bundle 'tsukkee/unite-tag'

Bundle 'tomtom/tcomment_vim'

Bundle 'thinca/vim-ref'

Bundle 'taku-o/vim-toggle'

Bundle 'mattn/zencoding-vim'

Bundle "kchmck/vim-coffee-script"

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
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbra ctermbg=0

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
let g:yankring_manual_clipboard_check = 0

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

" Reset hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" vim-funlib
function! Random(a, b)
    return random#randint(a:a, a:b)
endfunction
function! MD5(data)
    return hashlib#md5(a:data)
endfunction
function! Sha1(data)
    return hashlib#sha1(a:data)
endfunction
function! Sha256(data)
    return hashlib#sha1(a:data)
endfunction

" Justify
runtime macros/justify.vim

" Indent
vnoremap < <gv
vnoremap > >gv

" ref.vim
if has("win32") || has("win64")
    let g:ref_phpmanual_path = 'C:\phpmanual'
else
    let g:ref_phpmanual_path = '/phpmanual'
endif
nmap ,rp :<C-u>Ref phpmanual<Space>
nmap ,ra :<C-u>Ref alc<Space>

" smartchr
autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' == ', ' === ')
autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <expr> : smartchr#loop(':', ': ', '=>')
autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <expr> , smartchr#loop(', ', ',')
autocmd FileType ctp inoremap <buffer> <expr> = smartchr#loop('=', ' = ', ' == ', ' === ')
autocmd FileType ctp inoremap <expr> : smartchr#loop(':', ': ', '=>')
autocmd FileType ctp inoremap <expr> , smartchr#loop(', ', ',')
autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
autocmd FileType php inoremap <buffer> <expr> . smartchr#loop('.', '->')

" zencoding.vim
let g:user_zen_settings = {
            \'lang' : 'ja',
            \'html' : {
            \   'indentation' : '    ',
            \   'snippets' : {
            \       'flash' : "<object data=\"${cursor}\""
            \               ." type=\"application/x-shockwave-flash\""
            \               ." id=\"\" width=\"\" height=\"\">\n"
            \               ."<param name=\"movie\" value=\"\" />\n</object>",
            \       },
            \  },
            \'javascript' : {
            \   'indentation' : '  ',
            \   'snippets' : {
            \       'jq' : "$(function() {\n\t${cursor}${child}\n});",
            \       'jq:each' : "$.each(${cursor}, function(index, item){\n\t${child}\n});",
            \       'jq:click' : "$(${cursor}).click(function() {\n\t${child}\n});",
            \       'jq:ajax' : "$.ajax(${cursor}, {\n\t\n}).success(function(data) {\n\t\n}).error(function(xhr, textStatus, errorThrown) {\n\t\n});",
            \       'fn' : "(function() {\n\t${cursor}\n})();",
            \       'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
            \   },
            \},
            \'php' : {
            \   'filters' : 'php, html',
            \   'indentation' : '    ',
            \   'snippets' : {
            \       'php:tag' : "<?php\n\t${cursor}\n?>",
            \   },
            \},
            \'ctp' : {
            \   'filters' : 'php',
            \},
            \'css' : {
            \   'filters' : 'fc', 
            \}, 
\}
let g:use_zen_complete_tag = 1

" unite.vim
imap <C-k> <Plug>(neocomplcache_start_unite_complete)

" vim-coffee-script
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
