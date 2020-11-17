#!/usr/bin/env zsh

set -ex

stow `print *(/)` -t ~
nvim -u $HOME/.config/nvim/vimrc.bundles +PlugInstall! +PlugClean! +qall
