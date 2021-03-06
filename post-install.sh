#!/bin/bash 

# Atualiza repositórios:
pacman -Syy

# Define o idioma padrão do sistema:
sed -i '/en_US.U/,+1 s/^#//' /etc/locale.gen ; sed -i '/pt_BR/,+1 s/^#//' /etc/locale.gen ; echo LANG=pt_BR.UTF-8 > /etc/locale.conf ; locale-gen ; export LANG=pt_BR.UTF-8

# Define o idioma padrão do teclado:
loadkeys br-abnt ; echo -e "KEYMAP=br-abnt2\nFONT=Lat2-Terminus16\nFONT_MAP=" > /etc/vconsole.conf ; mkdir -p /etc/X11/xorg.conf.d ; echo -e 'Section "InputClass"\nIdentifier "Keyboard Defaults"\nMatchIsKeyboard "yes"\nOption "XkbLayout" "br"\nEndSection' | tee /etc/X11/xorg.conf.d/01-keyboard-layout.conf

# Define a hora local:
ln -sf /usr/share/zoneinfo/America/Belem /etc/localtime
sed -i '/NTP/,+1 s/^#//' /etc/systemd/timesyncd.conf ; systemctl enable systemd-timesyncd ; clear

# Habilita o uso do sudo a usuários do grupo wheel:
sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

# Define senha para o usuário root:
clear ; echo " "  ; echo "Senha para o usuário ROOT" ;  passwd ; sleep 2

# Cria e define uma senha para o usuário padrão:
clear ; echo "Digite o nome de usuário:" ; read usrname
useradd -m -g users -G wheel,storage,power -s /bin/bash $usrname ; sleep 1 ; clear ; echo "Senha do usuário" ; passwd $usrname ; chsh -s /bin/zsh $usrname
clear ; sleep 2

# Define o nome do host (maquina):
echo "archlinux" > /etc/hostname

# Instala o Grub:
echo "Instalando o grub em /mnt/boot..." ; sleep 2
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub --recheck ; grub-mkconfig -o /boot/grub/grub.cfg 

# Instala o xorg + extras:
pacman -S --noconfirm xorg xorg-xinit pulseaudio mesa xf86-video-intel vulkan-intel intel-ucode ttf-dejavu ttf-liberation noto-fonts nerd-fonts-hack

# Faz ajustes no interpretador de Byte-Code (BCI)
echo 'export FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 autofitter:warping=1"' | tee -a /etc/profile.d/freetype2.sh

# Instala o i3-gapps + extras:
pacman -S --noconfirm i3-gaps i3status dmenu hsetroot picom

# Instala aplicações:
pacman -S --noconfirm wget git curl yay p7zip file-roller ntfs-3g mtools dosfstools cups hdparm numlockx gvfs gvfs-mtp xdg-user-dirs xdg-utils xfce4-terminal oh-my-zsh-git zsh-syntax-highlighting xfce4-screenshooter thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman tumbler polkit-gnome gnome-disk-utility neofetch pluma ristretto lxappearance vlc qbittorrent firefox-i18n-pt-br

# Instala aplicação oficial telegram:
cd /tmp ; wget -c "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz ; tar Jxf telegram.tar.xz -C /opt/ ; ln -sf /opt/Telegram/Telegram /usr/local/bin/telegram

# Habilita serviços:
systemctl enable NetworkManager
systemctl enable bluetooth.service
systemctl enable org.cups.cupsd
systemctl enable fstrim.timer

clear ; echo " " ; echo "Script finalizado. Pressione uma tecla para encerrar." ; read tecla
