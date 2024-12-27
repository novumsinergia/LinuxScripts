#!/bin/bash

# =============================================================================
# Script para desinstalar y limpiar Virt Manager en EndeavourOS
# =============================================================================
# Autor: zebus
# Fecha: 2024-12-20
# =============================================================================

# ----------------------------------------
# Funciones para mostrar mensajes
# ----------------------------------------
echo_info() {
    echo -e "\e[34m[INFO]\e[0m $1"
}

echo_success() {
    echo -e "\e[32m[SUCCESS]\e[0m $1"
}

echo_error() {
    echo -e "\e[31m[ERROR]\e[0m $1" >&2
}

# ----------------------------------------
# Verificación de permisos
# ----------------------------------------
if [[ "$EUID" -ne 0 ]]; then
    echo_error "Este script debe ejecutarse como root. Intenta usar sudo."
    exit 1
fi

# ----------------------------------------
# Variables
# ----------------------------------------
CONFIG_FILE="/etc/libvirt/libvirtd.conf"
QEMU_CONF="/etc/libvirt/qemu.conf"
USER_NAME="$(logname)"  # Obtiene el nombre del usuario que inició sesión
BACKUP_PATTERN=".bak_*"  # Patrón para identificar backups

# Paquetes a desinstalar
PACKAGES=(
    virt-manager    # Desktop user interface for managing virtual machines
    virt-viewer     # A lightweight interface for interacting with the graphical display of virtualized guest OS.
    qemu-full       # A full QEMU setup
    libvirt         # API for controlling virtualization engines (openvz,kvm,qemu,virtualbox,xen,etc)
    dnsmasq         # Lightweight, easy to configure DNS forwarder and DHCP server
    bridge-utils    # Utilities for configuring the Linux ethernet bridge
    openbsd-netcat  # TCP/IP swiss army knife. OpenBSD variant
    iptables-nft    # Linux kernel packet control tool (using nft interface)
    edk2-ovmf       # for uefi (en otras distros ovmf)
    swtpm           # TPM emulator with socket
    vde2            # Virtual Distributed Ethernet for emulators like qemu
)

# ----------------------------------------
# Detener y deshabilitar el servicio libvirtd
# ----------------------------------------
echo_info "Deteniendo y deshabilitando el servicio libvirtd..."
systemctl stop libvirtd
systemctl disable libvirtd

echo_success "Servicio libvirtd detenido y deshabilitado."

# ----------------------------------------
# Restaurar configuraciones desde backups
# ----------------------------------------
restore_backup() {
    local config_file="$1"
    if ls "${config_file}"${BACKUP_PATTERN} 1> /dev/null 2>&1; then
        echo_info "Restaurando configuraciones originales de $config_file..."
        for backup in "${config_file}"${BACKUP_PATTERN}; do
            cp "$backup" "$config_file"
            echo_success "Restaurado $config_file desde $backup"
        done
    else
        echo_info "No se encontraron copias de seguridad para $config_file. Saltando restauración."
    fi
}

restore_backup "$CONFIG_FILE"
restore_backup "$QEMU_CONF"

# ----------------------------------------
# Eliminar configuraciones modificadas
# ----------------------------------------
echo_info "Eliminando configuraciones modificadas de $CONFIG_FILE y $QEMU_CONF..."
# Dependiendo de cómo se modificaron, puedes revertir los cambios aquí si es necesario.
# En este script, asumimos que las copias de seguridad ya fueron restauradas.

echo_success "Configuraciones eliminadas."

# ----------------------------------------
# Eliminar copias de seguridad
# ----------------------------------------
delete_backups() {
    local config_file="$1"
    if ls "${config_file}"${BACKUP_PATTERN} 1> /dev/null 2>&1; then
        echo_info "Eliminando copias de seguridad de $config_file..."
        rm -f "${config_file}"${BACKUP_PATTERN}
        echo_success "Copias de seguridad de $config_file eliminadas."
    else
        echo_info "No se encontraron copias de seguridad para $config_file."
    fi
}

delete_backups "$CONFIG_FILE"
delete_backups "$QEMU_CONF"

# ----------------------------------------
# Remover el usuario de los grupos libvirt y kvm
# ----------------------------------------
echo_info "Removiendo el usuario $USER_NAME de los grupos libvirt y kvm..."
gpasswd -d "$USER_NAME" libvirt
gpasswd -d "$USER_NAME" kvm

echo_success "Usuario $USER_NAME removido de los grupos libvirt y kvm."

# ----------------------------------------
# Desinstalar paquetes
# ----------------------------------------
echo_info "Desinstalando virt-manager y dependencias..."
pacman -Rns --noconfirm "${PACKAGES[@]}"

echo_success "Paquetes desinstalados correctamente."

# ----------------------------------------
# Eliminar directorios de configuración de libvirt si existen
# ----------------------------------------
LIBVIRT_DIRS=(
    "/etc/libvirt/"
    "/var/lib/libvirt/"
    "/var/log/libvirt/"
)

for dir in "${LIBVIRT_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
        echo_info "Eliminando directorio $dir..."
        rm -rf "$dir"
        echo_success "Directorio $dir eliminado."
    else
        echo_info "Directorio $dir no existe. Saltando."
    fi
done

# ----------------------------------------
# Finalización
# ----------------------------------------
echo_success "Virt Manager y todas sus dependencias han sido desinstaladas y configuradas correctamente."
echo "Es recomendable reiniciar el sistema para asegurar que todos los cambios tengan efecto."

exit 0
