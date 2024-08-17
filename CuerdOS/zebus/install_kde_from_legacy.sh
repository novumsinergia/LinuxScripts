#!/usr/bin/env bash

# Instalar plasma (sin metapaquete y sin konqueror) y desinstalar xfce:
sudo apt install plasma-desktop plasma-workspace dolphin kate kdialog kfind konsole udisks2 upower kwin-x11 sddm xserver-xorg ark gwenview kcalc kde-spectacle knotes kwalletmanager okular plasma-dataengines-addons plasma-pa plasma-runners-addons plasma-wallpapers-addons plasma-widgets-addons polkit-kde-agent-1 sweeper plasma-nm skanlite apper print-manager fonts-symbola iw x11-apps x11-session-utils xinit xorg

# Desinstalar xfce:
dpkg -l | grep .xfce. | awk '{print $2}' | xargs sudo apt-get purge -V --auto-remove -yy
dpkg -l | grep gnome | awk '{print $2}' | xargs sudo apt-get purge -V --auto-remove -yy
