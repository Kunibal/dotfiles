#!/bin/sh

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
sudo apt install fuse

# tools and co.
sudo apt install alacritty
sudo apt install ripgrep
sudo apt install eza
sudo apt install cloc
sudo apt install gh
sudo apt install strace && sudo apt install ltrace

# programming languages
# Rust
sudo apt install rustup
rustup default stable

# Golang
sudo apt install golang-go

# install node + npm through volta afterwards
curl https://get.volta.sh | bash
volta install node
