#!/bin/bash

DOTFILES=~/dotfiles

ln -s $DOTFILES/bashrc ~/.bashrc
ln -s $DOTFILES/tmux.conf ~/.tmux.conf

mkdir -p ~/.vim/bundle
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/vim/colors ~/.vim/
ln -s $DOTFILES/vim/bundle/Vundle.vim ~/.vim/bundle/

