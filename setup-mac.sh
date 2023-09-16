#!/bin/sh

xcode-select --install

curl -sSL https://get.rvm.io | bash -s stable --ruby
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://bun.sh/install | bash

brew install tmux
brew install alacritty
brew install neovim
brew install ripgrep
brew install node
brew install exa
brew install zsh-autosuggestions
