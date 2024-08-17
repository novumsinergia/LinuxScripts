#!/usr/bin/env bash

clear

function pacman_install(){
    
    # Compruebo si ya está instalado:
    if pacman -Qs $1 | grep "local/$1" &> /dev/null; then
    
        echo "✅ $1 está instalado, no se hace nada"
    
    else
    
        echo "💾 Instalando $1"
        sudo pacman -S --noconfirm $1
    
    fi
}

function yay_install(){
    
    # Convierto el argumento 1 en minusculas
    arg_lower=$(echo $1 | awk '{print tolower($0)}')
    
    # Compruebo si ya está instalado:
    if command -v $arg_lower &> /dev/null; then
    
        echo "✅ $1 ya está instalado, no se hace nada."
    
    else
    
        echo "💾 Instalando $1..."
        yay -S --noconfirm $2
    
    fi    

}

# Previews de las Miniaturas de archivos de blender
pacman_install "kdegraphics-thumbnailers"

# Extras para Kio (mejoras en files a traves de la red)
pacman_install "kio-extras"

# Previews de miniauras de los videos
pacman_install "ffmpegthumbs"

# Instalando Ark
pacman_install "ark"

# Instalando 7z
pacman_install "p7zip"

# Instalando KeePassXC
pacman_install "keepassxc"

# chequeo si existe git:
pacman_install "git"

# chequeo si existe yay:
if command -v yay &> /dev/null; then
    echo "✅ Yay ya está instalado, no se hace nada."
else
    echo "💾 Instalando yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
fi

# Instalando Brave
yay_install "Brave" "brave-bin"

# Instalando Discord
yay_install "Discord" "discord"

# Instalando Obsidian
yay_install "Obsidian" "obsidian"

# Instalando GPU Screen Recorder
yay_install "Gpu-Screen-Recorder" "gpu-screen-recorder"

# Instalando VSC
yay_install "Code" "visual-studio-code-bin"

# Configurando VSC
CURRENT_EXTENSIONS=$(code --list-extensions);
# echo $CURRENT_EXTENSIONS

if [ -z "${CURRENT_EXTENSIONS}" ]; then
  echo "💾 Instalando extensiones de VSC"
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (jacqueslucke\.blender-development) ]]; then
  code --install-extension JacquesLucke.blender-development
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (eamodio\.gitlens) ]]; then
  code --install-extension eamodio.gitlens
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (vscode-icons-team\.vscode-icons) ]]; then
  code --install-extension vscode-icons-team.vscode-icons
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-python\.debugpy) ]]; then
  code --install-extension ms-python.debugpy
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-python\.python) ]]; then
  code --install-extension ms-python.python
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-python\.vscode-pylance) ]]; then
  code --install-extension ms-python.vscode-pylance
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-vscode\.cmake-tools) ]]; then
  code --install-extension ms-vscode.cmake-tools
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-vscode\.cpptools) ]]; then
  code --install-extension ms-vscode.cpptools
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-vscode\.cpptools-extension-pack) ]]; then
  code --install-extension ms-vscode.cpptools-extension-pack
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (ms-vscode\.cpptools-themes) ]]; then
  code --install-extension ms-vscode.cpptools-themes
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (seanwu\.vscode-qt-for-python) ]]; then
  code --install-extension seanwu.vscode-qt-for-python
fi

if ! [[ "$CURRENT_EXTENSIONS" =~ (twxs\.cmake) ]]; then
  code --install-extension twxs.cmake
fi

FILE="settings.json"
SEP="/"
DEST_PATH="$HOME/.config/Code/User"
FULLPATH=$DEST_PATH$SEP$FILE

if [ -f $FULLPATH ]; then
    echo "✅ VSC el archivo $FILE ya existe!"
else

    if [ -f $FILE ]; then
        echo "💾 Escribiendo settings.json..."
        mkdir -p $DEST_PATH
        cp $FILE $FULLPATH
    fi
fi

# Instalando Github-Desktop (da conflicto y no instala)
# yay_install "Github-Desktop" "github-desktop-bin"

pacman_install "flatpak"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Instalando Github-Desktop
FLATPAKS=$(flatpak list);
if ! [[ "$FLATPAKS" =~ (io\.github\.shiftey\.Desktop) ]]; then
  echo "💾 Instalando Github Desktop"
  flatpak install flathub io.github.shiftey.Desktop
fi

# Instalando OBS Studio
if ! [[ "$FLATPAKS" =~ (com\.obsproject\.Studio) ]]; then
  echo "💾 Instalando OBS Studio"
  flatpak install flathub com.obsproject.Studio
fi
