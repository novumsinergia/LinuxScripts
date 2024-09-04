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


function check_and_install_yay(){
    if command -v yay &> /dev/null; then
        echo "✅ Yay ya está instalado, no se hace nada."
    else
        echo "💾 Instalando yay..."
        cd $HOME
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -sri
    fi
}
