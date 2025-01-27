#!/bin/sh

mkdir -p ~/.config/nvim
mkdir -p ~/.config/tmux
mkdir -p ~/.config/alacritty

ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/.config/nvim/lua ~/.config/nvim
ln -sf ~/dotfiles/.config/nvim/.stylua.toml ~/.config/nvim/.stylua.toml
ln -sf ~/dotfiles/mac/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ~/dotfiles/.config/alacritty/mac/alacritty.yml ~/.config/alacritty/alacritty.yml
