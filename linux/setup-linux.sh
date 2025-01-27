#!/bin/sh

# linux setup
# debian based

# in case there is no <tool-name>
sudo apt install -y curl
sudo apt install -y git

# install fonts
sudo apt install -y fonts-firacode

# First things first
# tmux + tmux plugin manager
sudo apt-get update && sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mkdir -p /opt/nvim
sudo mv nvim.appimage /opt/nvim/nvim
# needed for nvim to run AppImage
sudo apt install -y fuse

# tools and co.
sudo apt install -y alacritty
sudo apt install -y ripgrep
sudo apt install -y eza
sudo apt install -y cloc
sudo apt install -y gh
sudo apt install -y strace && sudo apt install ltrace
sudo apt install -y zsh-syntax-highlighting
sudo apt install -y zsh-autosuggestions

# programming languages
# Rust
sudo apt install -y rustup
rustup default stable

# Clang
sudo apt install clang
