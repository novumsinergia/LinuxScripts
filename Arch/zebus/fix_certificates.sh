#!/usr/bin/env bash

# importo mis functions:
source ./functions.sh

pacman_packages=(
    "reflector"
    "rsync"
)

for package in "${pacman_packages[@]}"; do
    install_package "pacman" "$package" "$package"
done

echo "Ejecutando reflector:"
sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syy