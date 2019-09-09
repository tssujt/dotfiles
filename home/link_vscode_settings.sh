#!/bin/sh

VSCODE_DOTFILES_PATH = "~/.homesick/repos/dotfiles/home/.vscode"
VSCODE_SETTINGS_PATH = "~/Library/Application\ Support/Code/User"

ln -sf $(VSCODE_DOTFILES_PATH)/settings.json $(VSCODE_SETTINGS_PATH)/settings.json
ln -sf $(VSCODE_DOTFILES_PATH)/keybindings.json $(VSCODE_SETTINGS_PATH)/keybindings.json

