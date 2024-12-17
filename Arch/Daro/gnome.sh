#! /bin/bash

sudo pacman -S gnome-shell gnome-tweaks --noconfirm

sudo pacman -S gdm gnome-characters gnome-backgrounds gnome-calendar gnome-clocks gnome-connections gnome-font-viewer gnome-logs gnome-maps gnome-remote-desktop gnome-color-manager gnome-control-center gnome-disk-utility gnome-keyring gnome-menus gnome-session gnome-settings-daemon gnome-shell-extensions gnome-system-monitor gnome-text-editor gnome-user-docs gnome-user-share gvfs-dnssd gvfs-wsdd loupe alacritty rygel sushi tecla tracker3-miners xdg-desktop-portal xdg-user-dirs-gtk yelp baobab evince  grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb nautilus gnome-terminal pacman-contrib amd-ucode intel-ucode vlc qbittorrent ark unrar p7zip grub-customizer firefox firefox-i18n-es-ar kdenlive obs-studio audacity libreoffice-fresh-es hunspell-es_uy telegram-desktop neofetch audacious gimp --noconfirm

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..

yay -S appimagelauncher-bin stacer-bin gnome-shell-extension-dash-to-dock gnome-shell-extension-compiz-alike-magic-lamp-effect-git gnome-shell-extension-compiz-windows-effect-git gnome-shell-extension-arc-menu-git archlinux-tweak-tool-git --noconfirm
sudo pacman -S ntfs-3g os-prober --noconfirm
sudo sed -i.bak "63s/.*/GRUB_DISABLE_OS_PROBER="false"/" /etc/default/grub

rm -rf ~/LinuxScripts



sudo systemctl enable gdm.service

grub-mkconfig -o /boot/grub/grub.cfg

reboot
