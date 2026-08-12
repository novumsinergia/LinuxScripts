#!/bin/bash

# ==========================================
# 1. AGREGAR REPOSITORIO NEMESIS (MÉTODO OFICIAL DE GITHUB)
# ==========================================
echo "==> Configurando el repositorio Nemesis (Erik Dubois)..."

# 1.1 Descargar e instalar la llave pública oficial de ArcoLinux
curl -s https://raw.githubusercontent.com/erikdubois/arcolinux-keyring/master/arcolinux-keyring.gpg | sudo pacman-key --add -
sudo pacman-key --lsign-key 313C52873130BCB0

# 1.2 Descargar e instalar los paquetes keyring y mirrorlist
wget https://github.com/erikdubois/arcolinux-keyring/raw/master/arcolinux-keyring-2026.01.01-1-any.pkg.tar.zst -O /tmp/arcolinux-keyring.pkg.tar.zst 2>/dev/null || wget https://github.com/erikdubois/arcolinux-keyring/raw/master/arcolinux-keyring-2024.03.11-1-any.pkg.tar.zst -O /tmp/arcolinux-keyring.pkg.tar.zst

sudo pacman -U /tmp/arcolinux-keyring.pkg.tar.zst --noconfirm

# 1.3 Agregar la entrada del repositorio Nemesis a /etc/pacman.conf si no existe
if ! grep -q "\[nemesis\]" /etc/pacman.conf; then
    sudo bash -c 'cat << EOF >> /etc/pacman.conf

[nemesis]
SigLevel = PackageRequired
Server = https://erikdubois.github.io/nemesis/\$repo/\$arch
EOF'
    echo "==> Repositorio [nemesis] añadido a pacman.conf"
fi

# 1.4 Sincronizar pacman con los nuevos repositorios
sudo pacman -Sy

# ==========================================
# 2. INSTALACIÓN DE PAQUETES DE PACMAN
# ==========================================
echo "==> Instalando entorno GNOME y herramientas..."
sudo pacman -S gnome-shell gnome-tweaks --noconfirm

sudo pacman -S gdm gnome-characters gnome-backgrounds gnome-calendar gnome-clocks gnome-connections gnome-font-viewer gnome-logs gnome-maps gnome-remote-desktop gnome-color-manager gnome-control-center gnome-disk-utility gnome-keyring gnome-menus gnome-session gnome-settings-daemon gnome-shell-extensions gnome-system-monitor gnome-text-editor gnome-user-docs gnome-user-share gvfs-dnssd gvfs-wsdd loupe alacritty rygel sushi tecla tracker3-miners xdg-desktop-portal xdg-user-dirs-gtk yelp baobab evince grilo-plugins gvfs gvfs-afc gvfs-goa gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb nautilus gnome-terminal pacman-contrib gnome-browser-connector amd-ucode intel-ucode vlc qbittorrent ark unrar p7zip firefox firefox-i18n-es-ar libreoffice-fresh-es hunspell-es_uy telegram-desktop fastfetch archlinux-tweak-tool --noconfirm

sudo pacman -S ntfs-3g os-prober --noconfirm

# ==========================================
# 3. INSTALACIÓN DE YAY Y PAQUETES AUR
# ==========================================
echo "==> Instalando YAY..."
# Dependencia necesaria para compilar paquetes desde AUR
sudo pacman -S --needed base-devel git --noconfirm

rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si --noconfirm
cd ..
rm -rf yay

echo "==> Instalando paquetes desde AUR..."
yay -S stacer-bin gnome-shell-extension-dash2dock-lite gnome-shell-extension-compiz-alike-magic-lamp-effect-git gnome-shell-extension-compiz-windows-effect-git gnome-shell-extension-arc-menu-git archlinux-tweak-tool-git --noconfirm

# ==========================================
# 4. CONFIGURACIÓN DEL SISTEMA Y GRUB
# ==========================================
echo "==> Habilitando os-prober en GRUB..."
sudo sed -i.bak "63s/.*/GRUB_DISABLE_OS_PROBER=\"false\"/" /etc/default/grub

echo "==> Limpiando carpeta del script..."
rm -rf ~/LinuxScripts

echo "==> Habilitando servicio GDM..."
sudo systemctl enable gdm.service

echo "==> Actualizando configuración de GRUB..."
sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "==> Reiniciando el sistema en 5 segundos..."
sleep 5
reboot
