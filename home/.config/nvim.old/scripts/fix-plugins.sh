#!/usr/bin/env sh
set -eu

if [ ! "$(command -v npm)" ]; then
    sudo pacman --needed --noconfirm -S npm nodejs
fi

cd ~/.local/share/lunarvim/site/pack/packer/start/bracey.vim/ || exit 1
npm install --prefix server

if [ ! "$(command -v yarn)" ]; then
    sudo pacman --needed --noconfirm -S yarn
fi

cd ~/.local/share/lunarvim/site/pack/packer/start/vim-prettier || exit 1
yarn install

echo "Finished!"
