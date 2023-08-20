#!/bin/sh

mkdir -p ~/.config/nvim
ln -sf ~/pc-settings/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/pc-settings/.config/nvim/after ~/.config/nvim/
ln -sf ~/pc-settings/.zshrc ~/.zshrc
ln -sf ~/pc-settings/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ~/pc-settings/.alacritty.yml ~/.config/alacritty/.alacritty.yml
