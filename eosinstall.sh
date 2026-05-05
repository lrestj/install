#!/bin/bash

set -e

echo
echo "##################################"
echo "#  Na jaký počítač instalujete?  #"
echo "#  Zbook = 1                     #"
echo "#  Probook = 2                   #"
echo "#  Mirantb = 3                   #"
echo "##################################"

while true; do
    read -r -n 1 -p " Vyberte 1/2/3: " answer
    case $answer in
        [1]* ) echo
               echo "####################################"
               echo "#                                  #"
               echo "#  Zvolili jste Zbook...           #"
               echo "#                                  #"
               echo "####################################"
               echo
               sleep 4 
               break;;
        [2]* ) echo
               echo "######################################"
               echo "#                                    #"
               echo "#  Zvolili jste Probook...           #"
               echo "#                                    #"
               echo "######################################"
               echo
               sleep 4 
               break;;
        [3]* ) echo
               echo "######################################"
               echo "#                                    #"
               echo "#  Zvolili jste Mirantb...           #"
               echo "#                                    #"
               echo "######################################"
               echo
               sleep 4
               break;;
         * ) echo "Vyberte 1, 2, nebo 3";;
     esac
done

PacmanApps=" bemoji font-manager cinnamon-translations cliphist evince foot fuzzel gvfs glxinfo galculator galculator jq network-manager-applet xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk udiskie simple-scan mako ttf-nerd-fonts-symbols ttf-hack-nerd awesome-terminal-fonts yazi fish waybar wlsunset geany grim libreoffice-fresh-cs qt6ct brightnessctl btop fastfetch papirus-icon-theme qutebrowser gparted mpv nemo vlc pamixer pdfarranger rclone qjackctl niri swaybg swayidle swaylock xournalpp zip p7zip wlsunset kitty kwalletmanager kwallet-pam nwg-look xorg-xwayland wayland-protocols 

AurApps="bibata-cursor-theme waypaper xfce-polkit" 

echo "##################################################"
echo "#  Spouštím instalaci, můžete zrušit CTRL+C ...  #"
echo "##################################################"
sleep 4
sudo pacman -Syu --noconfirm
echo
echo "#################################"
echo "#  Instalace z repozitáře Arch  #"
echo "#################################"
sudo pacman -S --noconfirm $PacmanApps &&

echo
echo "################################"
echo "#  Instalace z repozitáře Aur  #"
echo "################################"
yay -S --noconfirm $AurApps &&

    case $answer in
        [1]* ) echo
               echo "####################################"
               echo "#                                  #"
               echo "#  Probíhá konfigurace Zbook...    #"
               echo "#                                  #"
               echo "####################################"
               sudo pacman -S nvidia-inst
               nvidia-inst --prime
               git clone --bare -b endeavourOS --single-branch https://github.com/lrestj/probook.git $HOME/.cfg.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME checkout -f &&
               echo
               echo "###################################"
               echo "#  Konfigurace git repozitáře...  #"
               echo "###################################"
               git config --global user.email "rest@seznam.cz"
               git config --global user.name "LrestJ"
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME branch -m  main endeavourOS
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add github git@github.com:lrestj/voidlinux.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add gitlab git@gitlab.com:lrestj/voidlinux.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote -v
               ;;
        [2]* ) echo
               echo "######################################"
               echo "#                                    #"
               echo "#  Probíhá konfigurace Probook...    #"
               echo "#                                    #"
               echo "######################################"
               git clone --bare -b endeavourOS --single-branch https://github.com/lrestj/probook.git $HOME/.cfg.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME checkout -f &&
               echo
               echo "###################################"
               echo "#  Konfigurace git repozitáře...  #"
               echo "###################################"
               git config --global user.email "rest@seznam.cz"
               git config --global user.name "LrestJ"
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote remove origin
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add github git@github.com:lrestj/probook.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add gitlab git@gitlab.com:lrestj/probook.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote -v
               ;;
        [3]* ) echo
               echo "######################################"
               echo "#                                    #"
               echo "#  Probíhá konfigurace Mirantb...    #"
               echo "#                                    #"
               echo "######################################"
               git clone --bare -b endeavourOS --single-branch https://github.com/lrestj/probook.git $HOME/.cfg.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME checkout -f &&
               echo
               echo "###################################"
               echo "#  Konfigurace git repozitáře...  #"
               echo "###################################"
               git config --global user.email "rest@seznam.cz"
               git config --global user.name "LrestJ"
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote remove origin
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add github git@github.com:lrestj/mirantb.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add gitlab git@gitlab.com:lrestj/mirantb.git
               git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote -v
               ;;
         * ) echo "Vyberte 1, 2, nebo 3";;
     esac
  
echo "####################"
echo "#  Nastavení swap  #"
echo "####################"
echo vm.swappiness=10 | sudo tee /etc/sysctl.d/99-swappiness.conf
echo -e "\n"

echo
echo "###########################"
echo "#  Nfs Synology settings  #"
echo "###########################"
sudo cp -v /etc/fstab /etc/fstab.bak
cat $HOME/.dotfiles/nfs2fstab.txt | sudo tee -a /etc/fstab >> /dev/null

echo    
echo "############################"
echo "#  Autologin & swappiness  #"
echo "############################"
sudo cp -rf $HOME/.dotfiles/getty@tty1.service.d /etc/systemd/system/
sudo cp -rv /home/libor/.dotfiles/journald.conf.d /etc/systemd/
mkdir -p Templates Stažené Dokumenty Hudba Videa

echo
echo "################################"
echo "#  Konfigurace Git repozitářů  #"
echo "################################"
git clone https://github.com/lrestj/install $HOME/.dotfiles/install/
cd $HOME/.dotfiles/install/
git remote remove origin
git remote add github git@github.com:lrestj/install.git
git remote add gitlab git@gitlab.com:lrestj/install.git
git config --global user.email "rest@seznam.cz"
git config --global user.name "LrestJ"

echo
echo "#####################"
echo "#  KONEC INSTALACE  #" 
echo "#####################"

##### END OF FILE #####
