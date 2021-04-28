#!/usr/bin/env sh
set -eu

# Checks for npm and installs it if it is not present
if [ ! "$(command -v npm)" ] > /dev/null 2>&1; then
    sudo emerge --noreplace nodejs
fi

# Installs all the programs needed for nvim to not crash and start crying
sudo npm install -g tree-sitter-cli pyright emmet-ls

nvim -u $HOME/.config/nvim/init.lua "+PackerInstall"
nvim -u $HOME/.config/nvim/init.lua "+TSInstall bash cpp c css html java javascript json lua python regex rust toml typescript"

# LspInstall stuff
# bash cpp css efm html typescript json lua python vim yaml
