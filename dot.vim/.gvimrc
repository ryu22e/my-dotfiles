set showtabline=2
set transparency=10
set antialias
set guifont=Ricty:h14

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif
