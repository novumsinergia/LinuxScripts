#!/usr/bin/env bash

# importo mis functions:
source ./functions.sh

: '
    Este script sirve para despues de instalar CachyOS, instalar todo el software que normalmente utilizo
    incluidas las extensiones de Visual Studio Code, para poder tener todo lo que necesito de manera 
    fácil y sencilla y rápida. Solo faltaría personalizar kde y revisar los alias.

    Se debe ejecutar sin sudo, y si es ejecutado por segunda vez por error no pasaría nada. ya que
    hago comprobaciones de cada cosa antes de intentar instalar nada.
'

clear

# Variables
DEST_PATH="$HOME/.config/Code/User"
SETTINGS_FILE="settings.json"
FULLPATH="$DEST_PATH/$SETTINGS_FILE"
FLATHUB_REPO="https://dl.flathub.org/repo/flathub.flatpakrepo"


# Instalación de paquetes con Pacman
pacman_packages=(
    "brave-bin"
    "discord"
    "obs-studio"
    "obsidian"
    "keepassxc"
    "git"
    "flatpak"
    "telegram-desktop"
    "noto-fonts-emoji"
    "reflector"
    "rsync"
    "cronie"
)

for package in "${pacman_packages[@]}"; do
    install_package "pacman" "$package" "$package"
done


# Chequeo si existe yay, y sino lo instalamos:
check_and_install_yay

# Instalación de paquetes con Yay
yay_packages=(
    "visual-studio-code-bin"
    "anydesk-bin"
    "fuzzy-pkg-finder"
)

for package in "${yay_packages[@]}"; do
    if [[ "$package" == "fuzzy-pkg-finder" ]]; then
        install_package "yay" "$package" "fpf"
    else
        install_package "yay" "$package" "$(echo $package | awk -F'-' '{print $1}')"
    fi
done

# Configuración de extensiones de VSCode
CURRENT_EXTENSIONS=$(code --list-extensions)

vscode_extensions=(
    "JacquesLucke.blender-development"
    "eamodio.gitlens"
    "vscode-icons-team.vscode-icons"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-vscode.cmake-tools"
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"
    "ms-vscode.cpptools-themes"
    "seanwu.vscode-qt-for-python"
    "twxs.cmake"
)

for extension in "${vscode_extensions[@]}"; do
    code_install_extension "$CURRENT_EXTENSIONS" "$extension"
done

# Configuración de settings.json de VSCode
if [ -f "$FULLPATH" ]; then
    echo "✅ VSC: el archivo $SETTINGS_FILE ya existe!"
else
    if [ -f "$SETTINGS_FILE" ]; then
        echo "💾 Escribiendo $SETTINGS_FILE..."
        mkdir -p "$DEST_PATH"
        cp "$SETTINGS_FILE" "$FULLPATH"

        # Reemplazo el dummy ####USER#### por el usuario real actual: 
        sed -i "s@####USER####@$USER@g" $FULLPATH
    fi
fi

# Configuración de Flatpak y instalación de aplicaciones
flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO"

flatpak_apps=(
    "io.github.shiftey.Desktop"
)

FLATPAKS=$(flatpak list)

for app in "${flatpak_apps[@]}"; do
    if ! [[ "$FLATPAKS" =~ ($app) ]]; then
        echo "💾 Instalando $app"
        flatpak install flathub "$app"
    else
        echo "✅ $app ya está instalado."
    fi
done


# Comprobar si el servicio cronie está habilitado
if ! systemctl is-enabled cronie.service &> /dev/null; then
    echo "Habilitando el servicio cronie..."
    sudo systemctl enable cronie.service
    sudo systemctl start cronie.service
    echo "Servicio cronie habilitado y iniciado."
else
    echo "El servicio cronie ya está habilitado."
fi
