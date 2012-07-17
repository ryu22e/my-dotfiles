set showtabline=2
set transparency=10
set antialias
set guifont=Ricty:h14
colorscheme evening

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  set lines=60 columns=220
endif

Bundle 'pyflakes.vim'
