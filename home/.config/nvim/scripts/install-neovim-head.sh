#!/usr/bin/env sh
set -eu

CPUTHREADS="$(grep -c processor /proc/cpuinfo)"
sudo mkdir -p /usr/local/bin/

cd ~
sudo rm -rf neovim
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=Release -j"$CPUTHREADS" install
sudo cp build/bin/neovim /usr/local/bin/
cd ~
sudo rm -rf neovim
