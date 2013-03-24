#!/usr/bin/env bash

cp -r vimrc/.vimrc ~/.vimrc
rm -rf vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
echo "Installation successful!"
