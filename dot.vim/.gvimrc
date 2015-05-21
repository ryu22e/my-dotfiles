set showtabline=2
set antialias
if has('mac')
    set guifont=Ricty\ Diminished\ Discord\ Regular:h18
elseif has('unix')
    set guifont=Ricty\ Diminished\ 18
elseif has('win32')
    set guifont=Ricty_Diminished:h18
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ja_jp.utf-8
    source $VIMRUNTIME/menu.vim
endif
colorscheme evening

if has('gui_macvim')
  set transparency=10
endif

if has('gui_running')
  if has('gui_macvim')
    set fuoptions=maxvert,maxhorz
  endif
  set lines=60 columns=150
endif
