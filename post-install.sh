#!/bin/bash 

# Replaces pacman.conf
cp pacman.conf /etc

# Update repositories:
pacman -Syy

# Install i3-gaps + extras:
pacman -S --noconfirm i3-gaps i3status dmenu hsetroot picom

# Install packages and basic tools:
pacman -S --noconfirm wget git curl yay zsh zsh-syntax-highlighting p7zip file-roller ntfs-3g mtools dosfstools hdparm openssh numlockx gvfs gvfs-mtp xdg-user-dirs xdg-utils xfce4-terminal xfce4-screenshooter thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler polkit-gnome gnome-disk-utility neofetch pluma ristretto vlc qbittorrent firefox-i18n-pt-br lxappearance terminus-font noto-fonts noto-fonts-emoji ttf-dejavu ttf-liberation llvm linux linux-firmware nano networkmanager broadcom-wl wireless_tools wpa_supplicant dialog dhcpcd net-tools blueman

# Enable services:
systemctl enable NetworkManager
systemctl enable bluetooth.service
systemctl enable fstrim.timer

clear ; echo " " ; echo "Script finished. Press a key to end." ; read key
