#!/bin/sh

mkdir -p ~/.config/nvim
mkdir -p ~/.config/tmux
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/ghostty

ln -sf ~/dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/dotfiles/.config/nvim/lua ~/.config/nvim
ln -sf ~/dotfiles/.config/nvim/.stylua.toml ~/.config/nvim/.stylua.toml
ln -sf ~/dotfiles/linux/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ~/dotfiles/.config/tmux/tmux_session.sh ~/.config/tmux/tmux_session.sh
ln -sf ~/dotfiles/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf ~/dotfiles/.config/ghostty/config ~/.config/ghostty/config
ln -sf ~/dotfiles/.config/.ideavimrc ~/.ideavimrc
