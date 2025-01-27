#!/bin/sh

mkdir -p ~/.config/nvim
mkdir -p ~/.config/tmux
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/ghostty

ln -sf ~/pc-settings/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/pc-settings/.config/nvim/lua ~/.config/nvim
ln -sf ~/pc-settings/.config/nvim/.stylua.toml ~/.config/nvim/.stylua.toml
ln -sf ~/pc-settings/linux/.zshrc ~/.zshrc
ln -sf ~/pc-settings/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -sf ~/pc-settings/.config/tmux/tmux_session.sh ~/.config/tmux/tmux_session.sh
ln -sf ~/pc-settings/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -sf ~/pc-settings/.config/ghostty/config ~/.config/ghostty/config
