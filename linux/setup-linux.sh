#!/bin/sh

# First things first
sudo apt-get update && sudo apt install tmux
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim.appimage /opt/nvim/nvim

# tools and co.
sudo apt install alacritty
sudo apt install ripgrep
sudo apt install eza
sudo apt install zsh-autosuggestions
sudo apt install cloc
sudo apt install gh
sudo apt install strace && sudo apt install ltrace

# programming languages
sudo apt install rustup
sudo apt install rbenv
sudo apt install golang-go
curl https://get.volta.sh | bash
