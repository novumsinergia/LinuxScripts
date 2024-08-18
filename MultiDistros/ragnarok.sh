#!/bin/bash
#Estoes un script para usod e todos
echo " _______                                                           __                  ______                      _               _    ";
echo "|_   __ \                                                         [  |  _            .' ____ \                    (_)             / |_  ";
echo "  | |__) |    ,--.     .--./)  _ .--.    ,--.    _ .--.    .--.    | | / ]   ______  | (___ \_|  .---.   _ .--.   __    _ .--.   \`| |-' ";
echo "  |  __ /    \`'_\ :   / /'\`\; [ \`.-. |  \`'_\ :  [ \`/'\`\] / .'\`\ \  | '' <   |______|  _.____\`.  / /'\`\] [ \`/'\`\] [  |  [ '/'\`\ \  | |   ";
echo " _| |  \ \_  // | |,  \ \._//  | | | |  // | |,  | |     | \__. |  | |\`\ \           | \____) | | \__.   | |      | |   | \__/ |  | |,  ";
echo "|____| |___| \'-;__/  .',__\`  [___||__] \'-;__/ [___]     '.__.'  [__|  \_]           \______.' '.___.' [___]    [___]  | ;.__/   \__/  ";
echo "                     ( ( __))                                                                                          [__|             ";
                                                                                                                                         




echo " ____  _____                                                       ______     _                                         _           ";
echo "|_   \|_   _|                                                    .' ____ \   (_)                                       (_)          ";
echo "  |   \ | |     .--.    _   __   __   _    _ .--..--.    ______  | (___ \_|  __    _ .--.    .---.   _ .--.    .--./)  __    ,--.   ";
echo "  | |\ \| |   / .'\`\ \ [ \ [  ] [  | | |  [ \`.-. .-. |  |______|  _.____\`.  [  |  [ \`.-. |  / /__\\ [ \`/'\`\]  / /'\`\; [  |  \`'_\ :  ";
echo " _| |_\   |_  | \__. |  \ \/ /   | \_/ |,  | | | | | |           | \____) |  | |   | | | |  | \__.,  | |      \ \._//  | |  // | |, ";
echo "|_____|\____|  '.__.'    \__/    '.__.'_/ [___||__||__]           \______.' [___] [___||__]  '.__.' [___]     .',__\`  [___] \'-;__/ ";
echo "                                                                                                             ( ( __))               ";


echo "╔═╗┬─┐┌─┐┬ ┬┌─┐┌─┐┌┬┐┌─┐  ╦  ┬┌┐┌┬ ┬─┐ ┬┌─┐┬─┐┌─┐  ╦ ╦┬┌─┐┌─┐┌─┐┌┐┌┌─┐┬ ┬┌─┐┌┐ ┬  ┌─┐┌┐┌┌┬┐┌─┐";
echo "╠═╝├┬┘│ │└┬┘├┤ │   │ │ │  ║  │││││ │┌┴┬┘├┤ ├┬┘│ │  ╠═╣│└─┐├─┘├─┤││││ │├─┤├─┤├┴┐│  ├─┤│││ │ ├┤ ";
echo "╩  ┴└─└─┘ ┴ └─┘└─┘ ┴ └─┘  ╩═╝┴┘└┘└─┘┴ └─└─┘┴└─└─┘  ╩ ╩┴└─┘┴  ┴ ┴┘└┘└─┘┴ ┴┴ ┴└─┘┴─┘┴ ┴┘└┘ ┴ └─┘";

echo
# Función para imprimir texto con formato
print_text() {
    local text="$1"
    local color="$2"
    echo -ne "$(tput setaf $color)$(tput bold)$text$(tput sgr0)"
}

# Texto en ASCII
ascii_text() {
    local text="$1"
    local color="$2"
    echo -ne "$(tput setaf $color)$(tput bold)$text$(tput sgr0)"
}

# Mostrar el texto formateado
print_text "Escrito por: " 2
ascii_text "Lord_Sith_Muldorgs" 4
ascii_text " y " 5
ascii_text "ArcMetatron" 6
echo
echo


# Este script permite al usuario seleccionar su gestor de paquetes y realizar varias operaciones de mantenimiento del sistema.
# En esta actualizaciòn se elimina la pregunta al usuario del Sistema utilizado y se detecta automàticamente cual es el sistema instalado por su #gestor de paquetes
echo "EN ESTE SCRIPT POR REALIZARSE ALGUNAS OPERACIONES ADMINISTRATIVAS SE LE PEDIRÁ AL USUARIO VARIAS VECES SU CONTRASEÑA, SEA RESPONSABLE EN LA IMPLEMENTACIÓN DEL MISMO"

function base_action(){
   temp=true
   while $temp;do
   echo "$1 (s/n)"
  read confirm
  if [ "$confirm" == "s" ]; then
    if $2; then
      echo "$3"
      temp=false
    else
      echo "$4"
    fi
  else
    temp=false
  fi
 done
}
function flatpaks_packages(){
  if command -v flatpak &> /dev/null; then
      if flatpak list &> /dev/null; then
         base_action "Tiene paquetes flatpak instalados. ¿Desea actualizarlos?" "flatpak update" "Sus paquetes flatpaks han sido actualizados correctamente" "Ha fallado la actualización de sus paquetes flatpaks"
      fi
  fi
}

function snaps_packages(){
  if command -v snap &> /dev/null; then
      if snap list &> /dev/null; then
         base_action "Tiene paquetes flatpak instalados. ¿Desea actualizarlos?" "snap refresh" "Sus paquetes flatpaks han sido actualizados correctamente" "Ha fallado la actualización de sus paquetes flatpaks"
      fi
  fi
}

#Detección automática del Sistema instalado y realización de tareas en base al Sistema
if command -v apt >> /dev/null; then
    echo "Está utilizando Debian o una derivada, procederemos a realizar una actualización completa de su Sistema"
    update_and_upgrade(){
      sudo apt update && sudo apt upgrade
    }
    clean_cache(){
      sudo apt clean && sudo apt autoclean
    }
    base_action "¿Desea actualizar su Sistema?" update_and_upgrade "Actualización completada." "Hubo un error durante la actualización de su Sistema"
    flatpaks_packages
    snaps_packages
    base_action "¿Quieres eliminar los paquetes huérfanos?" "sudo apt autoremove" "Paquetes huérfanos eliminados." "Hubo un error al eliminar los paquetes huérfanos"
    base_action "¿Quieres eliminar la caché de paquetes?" clean_cache "Caché limpiada." "Hubo un error al limpiar la caché"

elif command -v pacman >> /dev/null; then
  # Actualización del sistema para Arch
  echo "Está utilizando Arch o una derivada, procederemos a realizar una actualización completa de su Sistema"
  update_and_upgrade(){
      sudo sudo pacman -Syu && yay -Syu
    }
    clean_orphaned(){
      yay -Rns $(yay -Qtdq)
    }
    clean_cache(){
      sudo pacman -Scc && sudo yay -Sc
    }
  base_action "¿Desea actualizar su Sistema?" update_and_upgrade "Actualización completada." "Hubo un error durante la actualización de su Sistema"
  flatpaks_packages
  snaps_packages
  base_action "¿Quieres eliminar los paquetes huérfanos?" clean_orphaned "Paquetes huérfanos eliminados." "Hubo un error al eliminar los paquetes huérfanos"
  base_action "¿Quieres eliminar la caché de paquetes?" clean_cache "Caché limpiada." "Hubo un error al limpiar la caché"

elif command -v rpm >> /dev/null; then
  echo "Está utilizando Fedora o una derivada, procederemos a realizar una actualización completa de su Sistema"
  base_action "¿Desea actualizar su Sistema?" "sudo dnf upgrade" "Actualización completada." "Hubo un error durante la actualización de su Sistema"
  flatpaks_packages
  snaps_packages
  base_action "¿Quieres eliminar los paquetes huérfanos?" "sudo dnf autoremove" "Paquetes huérfanos eliminados." "Hubo un error al eliminar los paquetes huérfanos"
  base_action "¿Quieres eliminar la caché de paquetes?" "sudo dnf clean all" "Caché limpiada." "Hubo un error al limpiar la caché"

else
  # Actualización del sistema para OpenSUSE
  echo "Está utilizando OpenSuse o una derivada, procederemos a realizar una actualización completa de su Sistema"
  
  update_and_upgrade(){
      sudo zypper refresh && sudo zypper up
    }

  base_action "¿Desea actualizar su Sistema?" update_and_upgrade "Actualización completada." "Hubo un error durante la actualización de su Sistema"
  flatpaks_packages
  snaps_packages
  # Eliminación de paquetes innecesarios en OpenSUSE
  temp=true
  while $temp;do
  echo "¿Quieres eliminar los paquetes innecesarios? (s/n)"
  read answer
  if [ "$answer" == "s" ]; then
    echo "Generando la lista de paquetes innecesarios..."
    packages=$(zypper pa --unneeded)
    IFS=$'\n' packages=($packages)
    for index in "${!packages[@]}"; do
      echo "$index) ${packages[$index]}"
    done
    echo "Introduce los números de los paquetes que quieres eliminar, separados por espacios. Introduce 'a' para eliminar todos los paquetes."
    read -a indices
    if [[ " ${indices[@]} " =~ " a " ]]; then
      if sudo zypper rm $(zypper pa --unneeded); then
        echo "Todos los paquetes innecesarios han sido eliminados."
        temp=false
      else
        echo "Hubo un error al eliminar los paquetes innecesarios"
      fi
    else
      for index in "${indices[@]}"; do
        package=$(echo ${packages[$index]} | awk '{print $3}')
        tempack=true
        while $tempack;do
        if sudo zypper rm $package; then
          echo "El paquete $package ha sido eliminado."
          tempack=false
        else
          echo "Hubo un error al eliminar el paquete $package. ¿Quieres reintentarlo? (s/n)"
          read retry
          if [ "$retry" == "n" ]; then
            tempack=false
          fi
        fi
        done
      done
    fi
    else
    temp=false
  fi
  done

  # Eliminación de instantáneas antiguas con snapper en OpenSUSE
  base_action "¿Quieres eliminar las instantáneas antiguas con snapper?" "sudo snapper cleanup number" "Las instantáneas antiguas han sido eliminadas." "Hubo un error al eliminar las instantáneas antiguas"
fi
#Aquí termina la actualización de los paquetes y la limpieza de caché

# Borrado de archivos temporales
echo "Borrado de los temporales"
base_action "¿Quieres eliminar los archivos temporales de /tmp?" "sudo rm -Rfv /tmp/*" "Archivos temporales eliminados." "Hubo un error al eliminar los archivos temporales"

# Vaciar la papelera de reciclaje
echo "Borrado total de la papelera de reciclaje. NOTA: con esta opción perderá todo lo que está en la papelera, no se podrá restaurar ni recuperar, piense bien antes de continuar"
echo "Mostrando el contenido de la papelera:"
ls -l ~/.local/share/Trash/files/
base_action "¿Desea vaciar la papelera de reciclaje? " "rm -rf ~/.local/share/Trash/files/*" "La papelera ha sido vaciada." "Hubo un error al vaciar la papelera"

