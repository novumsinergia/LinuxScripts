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
    "base-devel"
    "linux-headers"
    "nvidia-dkms"
)

for package in "${pacman_packages[@]}"; do
    install_package "$package"
done