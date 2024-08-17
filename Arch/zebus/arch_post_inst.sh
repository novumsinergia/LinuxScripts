#!/usr/bin/env bash

clear

# Previews de las Miniaturas de archivos de blender
if pacman -Qs kdegraphics-thumbnailers &> /dev/null; then
    echo "✅ Kde Graphics Thumbnailers está instalado, no se hace nada"
else
    echo "💾 Instalando Kde Graphics Thumbnailers"
    sudo pacman -S kdegraphics-thumbnailers
fi

# Extras para Kio (mejoras en files a traves de la red)
if pacman -Qs kio-extras &> /dev/null; then
    echo "✅ Kio Extras está instalado, no se hace nada"
else
    echo "💾 Instalando Kio Extras"
    sudo pacman -S kio-extras
fi

# Previews de miniauras de los videos
if pacman -Qs ffmpegthumbs &> /dev/null; then
    echo "✅ ffmpegthumbs está instalado, no se hace nada"
else
    echo "💾 Instalando ffmpegthumbs"
    sudo pacman -S ffmpegthumbs
fi

# Instalando Ark
if pacman -Qs ark | grep "local/ark" &> /dev/null; then
    echo "✅ Ark está instalado, no se hace nada"
else
    echo "💾 Instalando Ark"
    sudo pacman -S ark
fi

# Instalando 7z
if pacman -Qs 7z &> /dev/null; then
    echo "✅ p7zip está instalado, no se hace nada"
else
    echo "💾 Instalando p7zip"
    sudo pacman -S p7zip
fi

if command -v keepassxc &> /dev/null; then
    echo "✅ keepassxc está instalado, no se hace nada"
else
    echo "💾 Instalando keepassxc"
    sudo pacman -S keepassxc
fi

# chequeo si existe git:
if command -v git &> /dev/null; then
    echo "✅ Git ya está instalado, no se hace nada"
else
    echo "💾 Instalando Git..."
    sudo pacman -S git

fi

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
if command -v brave &> /dev/null; then
    echo "✅ Brave ya está instalado, no se hace nada."
else
    echo "💾 Instalando Brave..."
    yay -S brave-bin
fi

# Instalando Discord
if command -v discord &> /dev/null; then
    echo "✅ Discord ya está instalado, no se hace nada."
else
    echo "💾 Instalando Discord..."
    yay -S discord
fi

# Instalando Obsidian
if command -v obsidian &> /dev/null; then
    echo "✅ Obsidian ya está instalado, no se hace nada."
else
    echo "💾 Instalando Obsidian..."
    yay -S obsidian
fi

# Instalando GPU Screen Recorder
if command -v gpu-screen-recorder &> /dev/null; then
    echo "✅ gpu-screen-recorder ya está instalado, no se hace nada."
else
    echo "💾 Instalando gpu-screen-recorder..."
    yay -S gpu-screen-recorder
fi

# Instalando VSC
if command -v code &> /dev/null; then
    echo "✅ Visual Studio Code ya está instalado, no se hace nada."
else
    echo "💾 Instalando Visual Studio Code..."
    yay -S visual-studio-code-bin
fi


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
# if command -v github-desktop &> /dev/null; then
#     echo "✅ Github Desktop ya está instalado, no se hace nada."
# else
#     echo "💾 Instalando Github Desktop..."
#     yay -S github-desktop-bin
# fi

if command -v flatpak &> /dev/null; then
    echo "✅ flatpak está instalado, no se hace nada"
else
    echo "💾 Instalando flatpak"
    sudo pacman -S flatpak
fi

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
