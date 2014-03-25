set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

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

NeoBundle 'gmarik/vundle'
NeoBundle 'git-commit'
NeoBundle 'quickrun.vim'
NeoBundle 'Gist.vim'
NeoBundle 'PHP-dictionary'
NeoBundle 'matchit.zip'
NeoBundle 'speeddating.vim'
NeoBundle 'abolish.vim'
NeoBundle 'Justify'
NeoBundle 'smartchr'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'

NeoBundle 'Lokaltog/vim-powerline'

NeoBundle 'ynkdir/vim-funlib'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'tsukkee/unite-tag'

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-localrc'

NeoBundle 'taku-o/vim-toggle'

NeoBundle 'mattn/emmet-vim'

NeoBundle "kchmck/vim-coffee-script"

NeoBundle "rhysd/clever-f.vim"

NeoBundle 'osyo-manga/vim-over'

NeoBundle 'Rykka/riv.vim'

NeoBundleLazy 'tell-k/vim-autopep8', { "autoload": { "filetypes": ['python'] } }

if has('python')
    NeoBundleLazy 'pyflakes.vim', { "autoload": { "filetypes": ['python'] } }
    NeoBundleLazy 'davidhalter/jedi-vim', { "autoload": { "filetypes": ['python'] } }
endif

if v:version > 703
    NeoBundle 'cake.vim'
endif

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
nnoremap <silent> ,f :VimFiler<CR>

" template
:autocmd BufNewFile  *.pl      0r ~/.vim/template/skeleton.pl
:autocmd BufNewFile  *.py      0r ~/.vim/template/skeleton.py
:autocmd BufNewFile  *.rb      0r ~/.vim/template/skeleton.rb
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
            \       'jq' : "\\$(function() {\n\t${cursor}${child}\n});",
            \       'jq:each' : "\\$.each(${cursor}, function(index, item){\n\t${child}\n});",
            \       'jq:click' : "\\$(${cursor}).click(function() {\n\t${child}\n});",
            \       'jq:ajax' : "\\$.ajax(${cursor}, {\n\t\n}).success(function(data) {\n\t\n}).error(function(xhr, textStatus, errorThrown) {\n\t\n});",
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

" jedi and neocomplcache
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

" vim-over
nnoremap <silent> <Leader>m :OverCommandLine<CR>%s/

" golang
if $GOROOT != ''
    set rtp+=$GOROOT/misc/vim
endif
auto BufWritePre *.go Fmt

" autopep8
let s:bundle = neobundle#get("vim-autopep8")
function! s:bundle.hooks.on_source(bundle)
    let g:autopep8_disable_show_diff = 1
endfunction
unlet s:bundle
