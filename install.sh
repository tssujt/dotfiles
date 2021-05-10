#!/usr/bin/env zsh

set -ex

stow `print *(/)` -t $HOME
nvim -u $HOME/.config/nvim/vimrc.bundles +PlugInstall! +PlugClean! +qall
