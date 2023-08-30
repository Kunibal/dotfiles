#!/bin/sh

xcode-select --install
brew install tmux
brew install alacritty
brew install neovim
brew install ripgrep
brew install node
brew install exa
brew install zsh-autosuggestions

curl -sSL https://get.rvm.io | bash -s stable --ruby
