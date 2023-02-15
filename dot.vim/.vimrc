" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

filetype off

let g:rc_dir = expand('~/.vim/rc')
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = expand(s:dein_dir . '/repos/github.com/Shougo/dein.vim')

let g:python_host_prog = expand('~/.venv/nvim/python2/bin/python')
let g:python3_host_prog = expand('~/.venv/nvim/python3/bin/python')

if has('vim_starting')
    "dein Scripts-----------------------------
    if &compatible
        set nocompatible
    endif

    execute 'set runtimepath+=' . s:dein_repo_dir

    call dein#begin(s:dein_dir)

    " Let dein manage dein
    call dein#add(s:dein_repo_dir)

    " Add or remove your plugins here like this:
    " call dein#add('~/.cache/dein/repos/github.com/Shougo/neocomplete.vim')
    call dein#add('tomasr/molokai')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()

    filetype plugin indent on
    syntax enable

    " If you want to install not installed plugins on startup.
    if dein#check_install()
       call dein#install()
    endif

    "End dein Scripts-------------------------
endif

" osyo-manga/vim-over
nnoremap <silent> <Leader>m :OverCommandLine<CR>%s/

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

" colorscheme
if has('nvim')
    colorscheme molokai
    let g:rehash256 = 1
endif

" encoding
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp,euc-jp,cp932
set fileformats=unix,dos

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

" Disable Pydiction in default
let g:pydiction_location=''

" Key for buffers
noremap <C-j> <C-^>

" Move the cursor to the end of the previous line
:au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" vimgrep
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" incsearch
set incsearch
if has('migemo')
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

" Reset hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" Indent
vnoremap < <gv
vnoremap > >gv

" Keymaps for linux and windows
if !has('mac') && has('unix') || has('win32')
    source $VIMRUNTIME/mswin.vim
    unmap <C-V>
endif

if !has('kaoriya')
    command! -nargs=0 CdCurrent cd %:p:h
endif

"Related files, useful in Django
"Open files related to a Django project or app, as views.py, models.py or settings.py
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ("templates/")<cr>
nnoremap \7 :call RelatedFile ("templatetags/")<cr>
nnoremap \8 :call RelatedFile ("management/")<cr>
nnoremap \9 :e urls.py<cr>
nnoremap \0 :e settings.py<cr>

"Function used to open RelatedFile
fun! RelatedFile(file)
    "This is to check that the directory looks djangoish
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun! SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun

autocmd BufEnter *.py call SetAppDir()

" Setting the appropriate file type for Django template files
fun! SetFiletypeForDjangoTemplate()
    if filereadable(expand(getcwd() . '/manage.py'))
        set filetype=htmldjango
    endif
endfun

autocmd BufEnter *.html call SetFiletypeForDjangoTemplate()

" Open new tab
nnoremap <silent> <Leader>t :tabnew<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>
