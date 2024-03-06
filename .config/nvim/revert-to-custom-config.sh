#!/usr/bin/env bash

clear
printf "R U SURE?\n\nsleeping for 10 secs\n"
sleep 10
clear

# Make backup
printf "-----------------\nMaking backup ...\n-----------------\n"
mv ~/.config/nvim ~/.config/lazyvim-nvim.bak
mv ~/.local/share/nvim ~/.local/share/lazyvim-nvim.bak

# Restore backup
printf " -----------------------------\nRestoring previous backup ...\n-----------------------------\n"
mv ~/.config/nvim.bak ~/.config/nvim
mv ~/.local/share/nvim.bak ~/.local/share/nvim
