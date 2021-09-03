#!/bin/sh
set -e

mkdir -p $HOME/.config

ln -s $(pwd)/dot.zsh/.zsh $HOME/
ln -s $(pwd)/dot.zsh/.zshrc $HOME/

ln -s $(pwd)/dot.vim/.vim $HOME/
ln -s $(pwd)/dot.vim/.vimrc $HOME/
ln -s $(pwd)/dot.vim/.gvimrc $HOME/
ln -s $(pwd)/dot.vim/.vimrc $HOME/.config/nvim/init.vim

ln -s $(pwd)/dot.ack/.ackrc $HOME/

ln -s $(pwd)/dot.direnv/direnv $HOME/.config/direnv
