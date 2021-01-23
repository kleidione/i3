#!bin/bash

# Instala os pacotes básicos do archlinux:
pacstrap /mnt base base-devel linux linux-firmware grub efibootmgr nano blueman networkmanager nm-connection-editor wireless_tools broadcom-wl wpa_supplicant dialog net-tools

# Gera a fstab:
genfstab -U -p /mnt >> /mnt/etc/fstab

# Copia script post-install e pacman.conf >> /mnt:
cp pacman.conf /mnt/etc/ 
cp post-install.sh /mnt

# Entra em chroot >> /mnt e executa post-install:
arch-chroot /mnt sh post-install.sh
