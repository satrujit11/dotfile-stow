#!/bin/zsh

echo "Installing dotfiles"
# Stow all dotfiles
stow -v git
stow -v kitty
stow -v local_scripts
stow -v nvim
stow -v tmux
stow -v zsh

echo "Done"
