 #! /bin/bash

sudo pacman -S plasma-framework5 --noconfirm


git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..


sudo pacman -Rs xterm --noconfirm



rm -rf ~/LinuxScripts


