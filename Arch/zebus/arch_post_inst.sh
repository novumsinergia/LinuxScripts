#!/usr/bin/env bash


: '
    Este script sirve para despues de instalar arch, instalar todo el software que normalmente utilizo 
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


# Función genérica para instalar paquetes
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


function code_install_extension() {
    
    # Convertimos a minusculas el nombre de la extensión por si acaso:
    ext_name_lower=$(echo "$2" | awk '{print tolower($0)}')

    # Escapamos los puntos para construir el regex con el nombre de la extensión:
    regex=$(echo $ext_name_lower | sed "s/\./\\\./g")
    
    # Comprobamos si la extensión ya está instalada:
    if ! [[ "$1" =~ $regex ]]; then
        echo "💾 Instalando extensión $2"
        code --install-extension $ext_name_lower
    else
        echo "✅ La extensión $2 ya está instalada"
fi
}


# Instalación de paquetes con Pacman
pacman_packages=(
    "keepassxc"
    "git"
    "flatpak"
    "telegram-desktop"
    "mesa"
    "mesa-demos"
    "noto-fonts-emoji"
    "reflector"
    "rsync"
)

for package in "${pacman_packages[@]}"; do
    install_package "pacman" "$package" "$package"
done


# Chequeo si existe yay, y sino lo instalamos:
if command -v yay &> /dev/null; then
    echo "✅ Yay ya está instalado, no se hace nada."
else
    echo "💾 Instalando yay..."
    cd $HOME
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sri
fi

# Instalación de paquetes con Yay
yay_packages=(
    "brave-bin"
    "discord"
    "obsidian"
    "gpu-screen-recorder"
    "visual-studio-code-bin"
)

for package in "${yay_packages[@]}"; do
    install_package "yay" "$package" "$(echo $package | awk -F'-' '{print $1}')"
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
    "com.obsproject.Studio"
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
