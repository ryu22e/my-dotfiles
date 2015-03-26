set showtabline=2
set antialias
set guifont=Ricty:h18
colorscheme evening

if has('gui_macvim')
  set transparency=10
endif

if has("gui_running")
  if has('gui_macvim')
    set fuoptions=maxvert,maxhorz
  endif
  set lines=60 columns=150
endif
