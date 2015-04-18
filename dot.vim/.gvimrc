set showtabline=2
set antialias
if has("unix")
    set guifont=Ricty\ Diminished\ 18
elseif has("mac")
    set guifont=Ricty:h18
elseif has("win32")
    set guifont=Ricty_Diminished:h18
endif
set clipboard=unnamedplus,autoselect
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
