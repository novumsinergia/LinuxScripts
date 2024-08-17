#!/usr/bin/env bash

# Debian 12 testing (trixie) 2024

## Con este script puedeo chequear que paquetes tengo instalados o no actualmente en mi pc:
declare -a arr=("acpi" "acpi-support-base" "acpid" "adduser" "apt" "apt-utils" "aptitude" "base-files" "base-passwd" "bash" "bsdmainutils" "bsdutils" "busybox" "console-setup" "console-terminus" "coreutils" "cpio" "cron" "dash" "debconf" "debconf-i18n" "debian-archive-keyring" "debianutils" "diffutils" "discover" "discover-data" "dmidecode" "dmsetup" "dpkg" "e2fslibs" "e2fsprogs" "eject" "findutils" "gcc-4.4-base" "gettext-base" "gnupg" "gpgv" "grep" "groff-base" "grub-common" "grub-pc" "gzip" "hostname" "ifupdown" "info" "initramfs-tools" "initscripts" "insserv" "install-info" "installation-report" "iproute" "iptables" "iputils-ping" "isc-dhcp-client" "isc-dhcp-common" "kbd" "keyboard-configuration" "klibc-utils" "laptop-detect" "libacl1" "libattr1" "libaudit0" "libblkid1" "libboost-iostreams1.42.0" "libbz2-1.0" "libc-bin" "libc6" "libc6-i686" "libcomerr2" "libcwidget3" "libdb4.8" "libdevmapper1.02.1" "libdiscover2" "libdrm-intel1" "libdrm-radeon1" "libdrm2" "libept1" "libexpat1" "libfontenc1" "libfreetype6" "libgcc1" "libgcrypt11" "libgdbm3" "libgl1-mesa-dri" "libgpg-error0" "libice6" "libklibc" "liblocale-gettext-perl" "liblzma2" "libncurses5" "libncursesw5" "libnewt0.52" "libnfnetlink0" "libpam-modules" "libpam-runtime" "libpam0g" "libpci3" "libpciaccess0" "libpixman-1-0" "libpopt0" "libreadline5" "libreadline6" "libselinux1" "libsepol1" "libsigc++-2.0-0c2a" "libslang2" "libsm6" "libsqlite3-0" "libss2" "libssl0.9.8" "libstdc++6" "libtext-charwidth-perl" "libtext-iconv-perl" "libtext-wrapi18n-perl" "libudev0" "libusb-0.1-4" "libuuid-perl" "libuuid1" "libx11-6" "libx11-data" "libxapian22" "libxau6" "libxaw7" "libxcb1" "libxcomposite1" "libxdamage1" "libxdmcp6" "libxext6" "libxfixes3" "libxfont1" "libxkbfile1" "libxmu6" "libxpm4" "libxrandr2" "libxrender1" "libxt6" "linux-base" "linux-image-2.6-686" "linux-image-2.6.32-5-686" "locales" "login" "logrotate" "lsb-base" "lvm2" "man-db" "manpages" "mawk" "module-init-tools" "mount" "nano" "ncurses-base" "ncurses-bin" "net-tools" "netbase" "netcat-traditional" "passwd" "pciutils" "perl-base" "procps" "readline-common" "rsyslog" "sed" "sensible-utils" "sysv-rc" "sysvinit" "sysvinit-utils" "tar" "tasksel" "tasksel-data" "traceroute" "tzdata" "ucf" "udev" "usbutils" "util-linux" "vim-common" "vim-tiny" "virtualbox-ose-guest-utils" "virtualbox-ose-guest-x11" "wget" "whiptail" "x11-common" "x11-xkb-utils" "xfonts-base" "xfonts-encodings" "xfonts-utils" "xkb-data" "xserver-common" "xserver-xorg" "xserver-xorg-core" "xserver-xorg-input-evdev" "xz-utils" "zlib1g")

## now loop through the above array
for i in "${arr[@]}"; do

    if dpkg -l | grep -i "$i" >/dev/null ; then
        # echo package $i is installed in your system.
        : # usamos ":" como el "pass" de python
    else
        # CAN REMOVE THIS:
        # echo package $i is NOT installed in your system.
        echo $i
    fi

done
