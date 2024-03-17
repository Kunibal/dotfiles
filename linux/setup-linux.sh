#!/bin/sh

# First things first
sudo apt-get update && sudo apt install neovim && sudo apt install tmux

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
curl https://get.volta.sh | bash

# configure tools
export VOLTA_HOME=$HOME/.volta
export PATH=PATH:/$VOLTA_HOME/bin
