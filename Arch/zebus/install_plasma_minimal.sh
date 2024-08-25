#!/usr/bin/env bash

# importo mis functions:
source ./functions.sh

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
    "kdegraphics-thumbnailers"
    "kio-extras"
    "ffmpegthumbs"
)

for package in "${pacman_packages[@]}"; do
    install_package "pacman" "$package" "$package"
done