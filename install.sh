#!/usr/bin/env zsh

set -ex

stow `print *(/)` -t $HOME
