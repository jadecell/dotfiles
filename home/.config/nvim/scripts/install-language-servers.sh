#!/usr/bin/env sh
set -eu

# Checks for npm and installs it if it is not present
if [ ! command -v npm >/dev/null 2>&1 ]; then
    sudo pacman --noconfirm --needed -S npm nodejs
fi

# Installs all the language servers with npm
sudo npm install -g bash-language-server vscode-css-languageserver-bin vscode-html-languageserver-bin typescript typescript-language-server vscode-json-languageserver pyright vim-language-server yaml-language-server
