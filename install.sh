#!/bin/sh
set -e

ln -s `pwd`/dot.zsh/.zsh $HOME/
ln -s `pwd`/dot.zsh/.zshrc $HOME/

ln -s `pwd`/dot.vim/.vim $HOME/
ln -s `pwd`/dot.vim/.vimrc $HOME/
ln -s `pwd`/dot.vim/.gvimrc $HOME/

ln -s `pwd`/dot.ack/.ackrc $HOME/
