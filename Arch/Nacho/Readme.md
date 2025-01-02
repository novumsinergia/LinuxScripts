Script postinstall con Autodestrucción al finalizar

Este script automatiza las siguientes acciones en un entorno basado en Arch Linux:

    Instalación de plasma-framework5: Descarga e instala el framework necesario para entornos Plasma de KDE.
    Instalación de yay: Instala el gestor de paquetes AUR helper yay.
    Desinstalación de xterm: Elimina el emulador de terminal xterm del sistema.
    Autodestrucción del script: Una vez completadas todas las tareas, el script se elimina a sí mismo para evitar residuos en el sistema.

⚠️ Advertencia

Este script está diseñado para ser ejecutado luego de la instalación de "Calamares-ArchLinux-ns" cuya iso se puede descargar en la siguiente dirección web: https://sourceforge.net/projects/calamares-archlinux-ns/


⚠️ Pasos a seguir:

    Clona este repositorio.
    Ejecuta el script: sh postinstall.sh
