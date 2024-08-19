#!/usr/bin/env bash

function install_package() {
  
    local package_manager=$1
    local package_name=$2
    local command_check=$3

    # Comprobar si el paquete ya está instalado
    if command -v $command_check &> /dev/null || pacman -Qs $package_name | grep "local/$package_name" &> /dev/null; then
    
        echo "✅ $package_name ya está instalado, no se hace nada."
    
    else
        
        echo "💾 Instalando $package_name..."
        
        if [[ $package_manager == "pacman" ]]; then
            sudo pacman -S --noconfirm $package_name

        elif [[ $package_manager == "yay" ]]; then
            yay -S --noconfirm $package_name
        
        fi
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
    install_package "pacman" "$package" "$package"
done