set showtabline=2
set transparency=10
set antialias
set guifont=Ricty:h18
colorscheme evening

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set lines=60 columns=150
endif

Bundle 'pyflakes.vim'
