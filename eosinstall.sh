#!/bin/bash

PacmanApps="font-manager cliphist evince foot fuzzel gvfs glxinfo galculator greetd greetd-tuigreet galculator jq network-manager-applet xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk udiskie simple-scan breeze mako ttf-nerd-fonts-symbols ttf-hack-nerd awesome-terminal-fonts yazi fish waybar lxqt-policykit wlsunset geany grim libreoffice-fresh-cs qt6ct brightnessctl btop fastfetch papirus-icon-theme qutebrowser gparted mpv vlc pamixer pdfarranger rclone qjackctl niri swaybg swayidle swaylock xournalpp zip p7zip wlsunset kitty kwalletmanager kwallet-pam nwg-look xorg-xwayland wayland-protocols thunar thunar-archive-plugin nvidia-settings"

AurApps="autofs bemoji bibata-cursor-theme waypaper" 

echo "Spouštím instalaci, můžete zrušit CTRL+C ..."
sleep 4
sudo pacman -Syu
echo "Instalace z repozitáře Arch"
sudo pacman -S $PacmanApps &&
echo "Instalace z repozitáře Aur"
yay -S $AurApps &&
echo "Instalace dokončena"
sleep 4

# Clone repo
echo "Kopíruji konfiguraci z repozitáře"
git clone --bare -b endeavourOS --single-branch https://github.com/lrestj/probook.git $HOME/.cfg.git &&
git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME checkout -f
echo "Konfigurace z repozitáře kompletní"
echo -e "\n"
sleep 4

echo "Nastavení swap"
echo vm.swappiness=10 | sudo tee /etc/sysctl.d/99-swappiness.conf
echo -e "\n"

#NFS mounts
echo "Synology nfs shares"
echo -e "\n"
sudo mkdir /nfs &&
sudo chmod -R ugo+rwx /nfs
sudo cp -f /home/libor/.dotfiles/other/etc/autofs/* /etc/autofs/
sudo systemctl enable autofs.service
echo -e "\n"
echo "Připojení Nas Synology proběhlo úspěšně"
echo -e "\n"
sleep 4

#Greetd greeter
echo "Nastavuji Greetd"
sudo cp -f ~/.dotfiles/greetd/* /etc/greetd/
sudo systemctl enable greetd.service

#Nvidia prime
#echo "Nastavuji Nvidia prime"
#sleep 2
#nvidia-inst --prime

mkdir -p Public Templates Stažené Dokumenty Hudba Videa

git clone https://github.com/lrestj/install $HOME/.dotfiles/install/
cd $HOME/.dotfiles/install/
git remote remove origin
git remote add github git@github.com:lrestj/install.git
git remote add gitlab git@gitlab.com:lrestj/install.git
git config --global user.email "rest@seznam.cz"
git config --global user.name "LrestJ"


#Git remote repos
echo "Konfigurace Git repozitářů"
git --git-dir=/home/libor/.cfg.git/ --work-tree=/home/libor remote remove origin
git --git-dir=/home/libor/.cfg.git/ --work-tree=/home/libor remote add github git@github.com:lrestj/probook.git
git --git-dir=/home/libor/.cfg.git/ --work-tree=/home/libor remote add gitlab git@gitlab.com:lrestj/probook.git
git config --global user.email "rest@seznam.cz"
git config --global user.name "LrestJ"
echo "Remote repos added"
echo -e "\n"
sleep 4

#$PATH
echo "Add $HOME/.local/bin to $PATH"
sleep 4
EDITOR=vim sudoedit /etc/profile
echo "KONEC INSTALACE" 

##### END OF FILE #####
