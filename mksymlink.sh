#!/bin/bash

DOTFILES=~/dotfiles

ln -s $DOTFILES/bashrc ~/.bashrc

mkdir -p ~/.vim/bundle
ln -s $DOTFILES/vimrc ~/.vimrc
ln -s $DOTFILES/vim/colors ~/.vim/
ln -s $DOTFILES/vim/bundle/Vundle.vim ~/.vim/bundle/

