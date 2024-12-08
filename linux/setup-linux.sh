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

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo apt update -y && sudo apt install -y gpg wget curl
sudo install -dm 755 /etc/apt/keyrings
wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1>/dev/null
echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
sudo apt update
sudo apt install -y mise

sudo apt install -y libyaml-dev
mise use --global ruby@3.3
mise x ruby -- gem install rails --no-document
mise use --global node@lts

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

# Golang
sudo apt install -y golang-go

# Clang
sudo apt install clang
