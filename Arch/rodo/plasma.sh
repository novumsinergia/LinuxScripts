 #! /bin/bash

sudo pacman -S plasma-desktop plasma-pa powerdevil plasma-nm kscreen sddm sddm-kcm --noconfirm

sudo pacman -S amd-ucode intel-ucode kwalletmanager kdeplasma-addons spectacle dolphin konsole gwenview kate okular vlc qbittorrent ark unrar p7zip partitionmanager plasma-systemmonitor kcalc kde-gtk-config breeze-gtk plasma-framework5 kinfocenter grub-customizer firefox firefox-i18n-es-ar kdenlive obs-studio audacity libreoffice-fresh-es hunspell-es_ar telegram-desktop audacious ufw gufw gimp --noconfirm

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm && cd ..

yay -S appimagelauncher-bin stacer-bin --noconfirm
sudo pacman -S ntfs-3g os-prober --noconfirm
sudo sed -i.bak "63s/.*/GRUB_DISABLE_OS_PROBER="false"/" /etc/default/grub

rm -rf ~/LinuxScripts

cat << "EOF" >> ~/.config/kwalletrc
[Wallet]
Close When Idle=false
Close on Screensaver=false
Default Wallet=kdewallet
Enabled=false
Idle Timeout=10
Launch Manager=false
Leave Manager Open=false
Leave Open=true
Prompt on Open=false
Use One Wallet=true

[org.freedesktop.secrets]
apiEnabled=true

EOF

sudo systemctl enable ufw.service
sudo systemctl enable sddm.service


reboot
