#!/usr/bin/env bash

# importo mis functions:
source ./functions.sh

pacman_packages=(
    "base-devel"
    "linux-headers"
    "nvidia-dkms"
)

for package in "${pacman_packages[@]}"; do
    install_package "pacman" "$package" "$package"
done