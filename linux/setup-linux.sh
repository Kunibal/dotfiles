#!/bin/sh

# First things first
sudo apt-get update && sudo apt install tmux
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mkdir -p /opt/nvim
mv nvim.appimage /opt/nvim/nvim

# tools and co.
sudo apt install alacritty
sudo apt install ripgrep
sudo apt install eza
sudo apt install zsh-autosuggestions
sudo apt install cloc
sudo apt install strace && sudo apt install ltrace

# programming languages
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo apt install rbenv
sudo apt install golang-go
curl https://get.volta.sh | bash

# configure tools
export VOLTA_HOME=$HOME/.volta
export PATH=PATH:/$VOLTA_HOME/bin
