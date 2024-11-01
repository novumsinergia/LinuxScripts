 #! /bin/bash

sudo pacman -S plasma-desktop plasma-pa powerdevil plasma-nm kscreen sddm sddm-kcm --noconfirm

sudo pacman -S kwalletmanager kdeplasma-addons spectacle dolphin konsole gwenview kate okular vlc qbittorrent ark unrar p7zip partitionmanager plasma-systemmonitor kcalc kde-gtk-config breeze-gtk plasma-framework5 kinfocenter grub-customizer firefox firefox-i18n-es-ar kdenlive obs-studio audacity libreoffice-fresh-es hunspell-es_ar telegram-desktop audacious gimp --noconfirm

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..

yay -S appimagelauncher-bin stacer-bin --noconfirm
sudo pacman -S ntfs-3g os-prober --noconfirm
sudo sed -i.bak "63s/.*/GRUB_DISABLE_OS_PROBER="true"/" /etc/default/grub

rm -rf ~/Sinergia

cp ~/Sinergia/kwalletrc ~/.config/kwalletrc

sudo systemctl enable sddm.service

reboot




