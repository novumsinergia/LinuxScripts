#!/usr/bin/env bash

# importo mis functions:
source ./functions.sh

# Chequeo si existe yay, y sino lo instalamos:
check_and_install_yay

# Instalación de paquetes con Yay
yay_packages=(
    "fuzzy-pkg-finder"
)

for package in "${yay_packages[@]}"; do
    install_package "yay" "$package" "fpf"
done
