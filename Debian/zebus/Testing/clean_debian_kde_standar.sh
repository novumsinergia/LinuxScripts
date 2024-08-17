#!/usr/bin/env bash 

# Debian 12 testing (trixie) 2024

# WHITELISTS:
wl_plasma="plasma-desktop plasma-workspace dolphin kate kdialog kfind konsole udisks2 upower kwin-x11 sddm xserver-xorg ark gwenview kcalc kde-spectacle knotes kwalletmanager okular plasma-dataengines-addons plasma-pa plasma-runners-addons plasma-wallpapers-addons plasma-widgets-addons polkit-kde-agent-1 sweeper plasma-nm skanlite apper print-manager fonts-symbola iw x11-apps x11-session-utils xinit xorg"
wl_live_task_standard="apt-listchanges bash-completion bind9-host bzip2 dbus libpam-systemd file gettext-base groff-base krb5-locales libc-l10n liblockfile-bin libnss-systemd locales lsof man-db media-types openssh-client pciutils perl python3 traceroute ucf usbutils wget xz-utils"
wl_zebus="vim build-essential mesa-utils git gpm curl dolphin-plugins acpi acpid powertop iptables firewalld plasma-firewall aspell aspell-es pipewire pipewire-audio-client-libraries pulseaudio-utils wireplumber libspa-0.2-bluetooth keepassxc"

# BLACKLISTS:
bl_plasma="kde-plasma-desktop task-kde-desktop kde-standard kwrite kontrast kdeaccessibility kde-baseapps konqueror konq-plugins akregator dragonplayer juk kaddressbook khelpcenter kmail korganizer keditbookmarks kwrite plasma-browser-integration libreoffice* pocketsphinx-en-us espeak-ng-data partitionmanager libreoffice-style-breeze kmouth xterm exim4-base zutty plasma-welcome"
bl_live_task_standard="live-task-standard live-task-standard debian-faq doc-debian inetutils-telnet reportbug manpages manpages-dev live-task-base live-task-localisation ncurses-term wamerican"
bl_zebus="nano aptitude firefox-esr kmag netcat-openbsd eject pulseaudio aspell-en bin86 console-common debian-faq* dhcp3-client doc-debian fdutils hplip iamerican ibritish mtools mtr-tiny net-tools openssh-server pppconfig pppoe pppoeconf read-edid tcsh whois bsdmainutils virtualbox-guest-additions-iso boinc-virtualbox kdoctools5 libdecor-0-plugin-1-gtk libkpmcore12 libxml2-utils manpages-es console-data docbook-xml docbook-xsl nvidia-cuda-toolkit-doc"

# unimos (concatenamos) las listas de los metapackages:
WHITELIST="$wl_plasma $wl_live_task_standard $wl_zebus"
BLACKLIST="$bl_plasma $bl_live_task_standard $bl_zebus"

cd /var/cache/apt/archives/ &&

# Primero me aseguro de tener los paquetes previamente descargados (por lo que pueda pasar):
sudo apt download $WHITELIST

# Limpiando el sistema actual (en este momento uso chrome, por eso quito firefox-esr):
sudo apt purge $BLACKLIST

# Limpiando posibles restos:
sudo apt autoremove

# Instalacion minima de kde plasma:
sudo apt install $WHITELIST

# Limpiando las caches para vaciar /var/cache/apt/archives/:
# sudo apt-get clean
# sudo apt-get autoclean

