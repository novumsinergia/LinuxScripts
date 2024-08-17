#!/usr/bin/env bash

# Debian 12 testing (trixie) 2024

# View status:
# systemctl status --user pipewire

pulseaudio --kill
sudo apt purge pulseaudio
sudo apt install -y pipewire pipewire-audio-client-libraries pulseaudio-utils wireplumber libspa-0.2-bluetooth
systemctl --user restart wireplumber pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service
