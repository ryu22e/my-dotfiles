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

NeoBundle 'git-commit'
let git_diff_spawn_mode = 1

NeoBundle 'quickrun.vim'
NeoBundle 'Gist.vim'

NeoBundle 'matchit.zip'
runtime macros/matchit.vim
let b:match_words = &matchpairs . "\<if\>:\<end if\>,\<if\>:\<endif\>"
let b:match_ignorecase = 1

NeoBundle 'speeddating.vim'
NeoBundle 'abolish.vim'

NeoBundle 'Justify'
runtime macros/justify.vim

NeoBundleLazy 'smartchr', {
    \'autoload' : { 'insert' : 1 },
\}
let s:bundle = neobundle#get('smartchr')
function! s:bundle.hooks.on_source(bundle)
    autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' == ')
    autocmd FileType php,javascript inoremap <buffer> <expr> = smartchr#loop(' = ', '=', ' == ', ' === ')
    autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <expr> : smartchr#loop(':', ': ', '=>')
    autocmd FileType coffee,c,cpp,ruby,perl,python,php,javascript inoremap <expr> , smartchr#loop(', ', ',')
    autocmd FileType ctp inoremap <buffer> <expr> = smartchr#loop('=', ' = ', ' == ', ' === ')
    autocmd FileType ctp inoremap <expr> : smartchr#loop(':', ': ', '=>')
    autocmd FileType ctp inoremap <expr> , smartchr#loop(', ', ',')
    autocmd FileType c,cpp inoremap <buffer> <expr> . smartchr#loop('.', '->', '...')
    autocmd FileType php inoremap <buffer> <expr> . smartchr#loop('.', '->')
endfunction
unlet s:bundle

NeoBundle 'Rykka/clickable.vim'
NeoBundle 'Rykka/clickable-things'
NeoBundle 'Rykka/os.vim'

NeoBundleLazy 'Shougo/neocomplete.vim', {
    \'depends' : 'Shougo/vimproc',
    \'disabled' : !has('lua'),
    \'autoload' : { 'insert' : 1,}
\}
let s:bundle = neobundle#get('neocomplete.vim')
function! s:bundle.hooks.on_source(bundle)
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \'default' : ''
    \}
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    " key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
endfunction
unlet s:bundle

NeoBundleLazy 'Shougo/vimfiler', {
\   'autoload' : {
\       'commands' : ['VimFiler', 'VimFilerCurrentDir',
\                     'VimFilerBufferDir', 'VimFilerSplit',
\                     'VimFilerExplorer', 'VimFilerDouble'],
\   },
\   'depends': [ 'Shougo/unite.vim' ],
\ }
let s:bundle = neobundle#get('vimfiler')
function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
endfunction
unlet s:bundle
nnoremap <silent> ,f :VimFilerBufferDir<CR>
NeoBundleLazy 'Shougo/unite.vim' , {
\   'autoload' : { 'commands' : [ 'Unite' ] }
\ }
NeoBundle 'Shougo/vimproc', {
\   'build': {
\       'mac': 'make -f make_mac.mak',
\       'unix': 'make -f make_unix.mak',
\   },
\}
NeoBundleLazy 'Shougo/vimshell', {
\   'autoload' : { 'commands' : [ 'VimShellBufferDir' ] },
\   'depends': [ 'Shougo/vimproc' ],
\}

NeoBundle 'Lokaltog/vim-powerline'
let g:Powerline_symbols = 'fancy'

NeoBundle 'ynkdir/vim-funlib'
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

NeoBundle 'tpope/vim-surround'
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'tsukkee/unite-tag'

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'thinca/vim-ref'
if has('win32') || has('win64')
    let g:ref_phpmanual_path = 'C:\phpmanual'
else
    let g:ref_phpmanual_path = '/phpmanual'
endif
nmap ,rp :<C-u>Ref phpmanual<Space>
nmap ,ra :<C-u>Ref alc<Space>

NeoBundle 'thinca/vim-localrc'

NeoBundle 'taku-o/vim-toggle'

NeoBundleLazy 'mattn/emmet-vim', {
            \'autoload':
            \{
            \'filetypes': ['html', 'htmldjango', 'smarty']
            \}
            \}

NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload': { 'filetypes': ['coffee'] } }

NeoBundle 'rhysd/clever-f.vim'

NeoBundleLazy 'osyo-manga/vim-over', {
            \'autoload': {
            \'commands': ['OverCommandLine']
            \}
            \}
nnoremap <silent> <Leader>m :OverCommandLine<CR>%s/

NeoBundle 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--max-line-length=160'
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_rst_checkers = ['rstcheck']

if has('gui_running') && has('python')
    NeoBundle 'SirVer/ultisnips'
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger='<c-j>'
    let g:UltiSnipsJumpBackwardTrigger='<c-p>'
    let g:UltiSnipsListSnippets='<c-k>'
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit='vertical'
    NeoBundle 'honza/vim-snippets'
endif

NeoBundleLazy 'Rykka/riv.vim', { 'autoload': { 'filetypes': ['rst'] } }

NeoBundleLazy 'tell-k/vim-autopep8', {
    \'autoload': {
        \'filetypes': [ 'python' ],
        \'commands': [ 'Autopep8' ],
    \}
\}
let s:bundle = neobundle#get('vim-autopep8')
function! s:bundle.hooks.on_source(bundle)
    let g:autopep8_disable_show_diff = 1
endfunction
unlet s:bundle

NeoBundleLazy 'django.vim', { 'autoload': { 'filetypes': ['python'] } }

NeoBundleLazy 'jmcomets/vim-pony', {
            \'autoload':
            \{
            \'filetypes': ['python', 'htmldjango'],
            \'commands': [
                \'Dadmin',
                \'Dmodels',
                \'Dsettings',
                \'Dtests',
                \'Durls',
                \'Dviews',
                \'Drunserver',
                \'Dr',
                \'Dsyncdb',
                \'Dsy',
                \'Dshell',
                \'Dsh',
                \'Ddbshell',
            \],
            \}
            \}

NeoBundleLazy 'derekwyatt/vim-scala', { 'autoload': { 'filetypes': ['scala'] } }

NeoBundleLazy 'fatih/vim-go', { 'autoload': { 'filetypes': ['go'] } }
let s:bundle = neobundle#get('vim-go')
function! s:bundle.hooks.on_source(bundle)
    auto BufWritePre *.go GoFmt
    au FileType go nmap <leader>b <Plug>(go-build)
    au FileType go nmap <leader>t <Plug>(go-test)
    au FileType go nmap <leader>c <Plug>(go-coverage)
endfunction
unlet s:bundle

if has('python')
    NeoBundleLazy 'davidhalter/jedi-vim', { 'autoload': { 'filetypes': ['python'] } }
    let s:bundle = neobundle#get('jedi-vim')
    function! s:bundle.hooks.on_source(bundle)
        autocmd FileType python setlocal omnifunc=jedi#completions
        let g:jedi#auto_vim_configuration = 0
        if !exists('g:neocomplete#force_omni_input_patterns')
            let g:neocomplete#force_omni_input_patterns = {}
        endif
        let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*' " enable quickrun let g:jedi#rename_command = "" let g:jedi#pydoc = ""
    endfunction
    unlet s:bundle
endif

NeoBundleLazy 'cespare/vim-toml', { 'autoload': { 'filetypes': ['toml'] } }

NeoBundleLazy 'chase/vim-ansible-yaml', { 'autoload': { 'filetypes': ['ansible'] } }

NeoBundleLazy 'elixir-lang/vim-elixir', { 'autoload': { 'filetypes': ['elixir'] } }

NeoBundleLazy 'Glench/Vim-Jinja2-Syntax', { 'autoload': { 'filetypes': ['jinja'] } }

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
