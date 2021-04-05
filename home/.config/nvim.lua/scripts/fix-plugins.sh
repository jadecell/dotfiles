#!/usr/bin/env sh
set -eu

if [ ! command -v npm ]; then
    sudo pacman --noconfirm -S npm
fi

cd ~/.local/share/nvim/site/pack/packer/start/bracey.vim/ || exit 1
npm install --prefix server

if [ ! command -v yarn ]; then
    sudo pacman --noconfirm -S yarn
fi

cd ~/.local/share/nvim/site/pack/packer/start/vim-prettier || exit 1
yarn install

echo "Finished!"
