#!/bin/bash

# =============================================================================
# Script para instalar y configurar Virt Manager en EndeavourOS
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
BACKUP_SUFFIX=".bak_$(date +%F_%T)"  # Sufijo para backups únicos

# Paquetes a instalar
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
)

# ----------------------------------------
# Actualizar el sistema
# ----------------------------------------
echo_info "Actualizando el sistema..."
pacman -Syu --noconfirm

echo_success "Sistema actualizado correctamente."

# ----------------------------------------
# Instalar paquetes necesarios
# ----------------------------------------
echo_info "Instalando virt-manager y dependencias..."
pacman -S --noconfirm "${PACKAGES[@]}"

echo_success "Paquetes instalados correctamente."


# ----------------------------------------
# Configuración de libvirtd.conf
# ----------------------------------------
if [[ -f "$CONFIG_FILE" ]]; then
    echo_info "Creando copia de seguridad de $CONFIG_FILE..."
    cp "$CONFIG_FILE" "${CONFIG_FILE}${BACKUP_SUFFIX}"
    echo_success "Copia de seguridad creada en ${CONFIG_FILE}${BACKUP_SUFFIX}"

    echo_info "Modificando $CONFIG_FILE..."
    sed -i '/unix_sock_group/s/^#//' "$CONFIG_FILE"
    sed -i '/unix_sock_rw_perms/s/^#//' "$CONFIG_FILE"
    echo_success "Configuración de $CONFIG_FILE actualizada."
else
    echo_error "El archivo $CONFIG_FILE no existe. Saliendo..."
    exit 1
fi

# ----------------------------------------
# Añadir usuario a los grupos libvirt y kvm
# ----------------------------------------
echo_info "Añadiendo el usuario $USER_NAME a los grupos libvirt y kvm..."
usermod -aG libvirt,kvm "$USER_NAME"

sudo -u "$USER_NAME" "newgrp libvirt"

echo_success "Usuario $USER_NAME añadido a los grupos libvirt y kvm."

# ----------------------------------------
# Habilitar y arrancar el servicio libvirtd
# ----------------------------------------
echo_info "Habilitando y arrancando el servicio libvirtd..."
systemctl enable libvirtd
systemctl start libvirtd

echo_success "Servicio libvirtd habilitado y arrancado."

# ----------------------------------------
# Configuración de qemu.conf
# ----------------------------------------
if [[ -f "$QEMU_CONF" ]]; then
    echo_info "Creando copia de seguridad de $QEMU_CONF..."
    cp "$QEMU_CONF" "${QEMU_CONF}${BACKUP_SUFFIX}"
    echo_success "Copia de seguridad creada en ${QEMU_CONF}${BACKUP_SUFFIX}"

    echo_info "Modificando $QEMU_CONF..."

    sed -i '/user = \"libvirt-qemu\"/s/^#//g' "$QEMU_CONF" # descomentamos
    sed -i -E "s/user = \"libvirt-qemu\"/user = \"$USER_NAME\"/" "$QEMU_CONF" # reemplazamos

    sed -i '/group = \"libvirt-qemu\"/s/^#//g' "$QEMU_CONF" # descomentamos
    sed -i -E "s/group = \"libvirt-qemu\"/group = \"$USER_NAME\"/" "$QEMU_CONF" # reemplazamos

    echo_success "Configuración de $QEMU_CONF actualizada."
else
    echo_error "El archivo $QEMU_CONF no existe. Saliendo..."
    exit 1
fi

echo_success "Servicio libvirtd reiniciado correctamente."

echo_info "Autoiniciando la red 'default'..."
sudo virsh net-autostart default

echo_info "Iniciando la red 'default'..."
sudo virsh net-start default || {echo_error "No se pudo iniciar la red 'default'. Puede que ya esté en funcionamiento."}

echo_success "Red de libvirt configurada correctamente."

# ----------------------------------------
# Reiniciar el servicio libvirtd
# ----------------------------------------
echo_info "Reiniciando el servicio libvirtd para aplicar cambios..."
systemctl restart libvirtd

# ----------------------------------------
# Finalización
# ----------------------------------------
echo_success "Virt Manager y todas las dependencias han sido instaladas y configuradas correctamente."
echo "Por favor, cierra la sesión y vuelve a iniciarla para que los cambios de grupos tengan efecto."
