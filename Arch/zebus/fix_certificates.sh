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
    "reflector"
    "rsync"
)

for package in "${pacman_packages[@]}"; do
    install_package "$package"
done

echo "Ejecutando reflector:"
sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy