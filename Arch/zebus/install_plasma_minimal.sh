#!/usr/bin/env bash

function install_package() {
  
    local package_name=$1

    # Comprobar si el paquete ya está instalado
    if command -v $package_name &> /dev/null || pacman -Qs $package_name | grep "local/$package_name" &> /dev/null; then
    
        echo "✅ $package_name ya está instalado, no se hace nada."
    
    else
        
        echo "💾 Instalando $package_name..."
        sudo pacman -S --noconfirm $package_name

    fi
}

pacman_packages=(
    "wayland"
    "xorg-xwayland" 
    "qt6-wayland"
    "plasma-desktop"
    "plasma-pa"
    "plasma-nm"
    "kscreen"
    "breeze-gtk"
    "plasma-systemmonitor"
    "kde-gtk-config"
    "dolphin"
    "ark"
    "gwenview"
    "kate"
    "kcalc"
    "konsole"
    "qbittorrent"
    "okular"
    "spectacle"
    "p7zip"
    "pipewire-jack"
    "pipewire"
    "gst-plugin-pipewire"
    "pipewire-audio"
    "wireplumber"
    "gst-libav"
    "ffmpeg4.4"
    "sddm"
)

for package in "${pacman_packages[@]}"; do
    install_package "$package"
done