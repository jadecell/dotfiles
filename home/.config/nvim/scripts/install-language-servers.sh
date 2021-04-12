#!/usr/bin/env sh
set -eu

# Checks for npm and installs it if it is not present
if [ ! command -v npm ] > /dev/null 2>&1; then
    sudo emerge --noreplace nodejs
fi

# # Installs all the language servers with npm
sudo npm install -g bash-language-server vscode-css-languageserver-bin vscode-html-languageserver-bin typescript typescript-language-server vscode-json-languageserver pyright vim-language-server yaml-language-server

mkdir ~/.config/nvim/ls
cd ~/.config/nvim/ls || exit 1
rm -rf lua-language-server
git clone https://github.com/sumneko/lua-language-server
cd lua-language-server
git submodule update --init --recursive

cd 3rd/luamake
ninja -f ninja/linux.ninja
cd ../..
./3rd/luamake/luamake rebuild

rm -rf ~/.config/nvim/ls/lua-language-server/.git
