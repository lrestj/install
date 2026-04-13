#!/bin/bash

PacmanApps="font-manager cliphist evince foot fuzzel gvfs glxinfo galculator greetd greetd-tuigreet galculator jq network-manager-applet xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk udiskie simple-scan breeze mako ttf-nerd-fonts-symbols ttf-hack-nerd awesome-terminal-fonts yazi fish waybar lxqt-policykit wlsunset geany grim libreoffice-fresh-cs qt6ct brightnessctl btop fastfetch papirus-icon-theme qutebrowser gparted mpv vlc pamixer pdfarranger rclone qjackctl niri swaybg swayidle swaylock xournalpp zip p7zip wlsunset kitty kwalletmanager kwallet-pam nwg-look xorg-xwayland wayland-protocols thunar thunar-archive-plugin 

AurApps="autofs bemoji bibata-cursor-theme waypaper" 

echo "##################################################"
echo "#  Spouštím instalaci, můžete zrušit CTRL+C ...  #"
echo "##################################################"
sleep 4
sudo pacman -Syu
echo
echo "#################################"
echo "#  Instalace z repozitáře Arch  #"
echo "#################################"
sudo pacman -S $PacmanApps &&

echo
echo "################################"
echo "#  Instalace z repozitáře Aur  #"
echo "################################"
yay -S $AurApps &&

echo
echo "##################################"
echo "#  Na jaký počítač instalujete?  #"
echo "#  Zbook = 1                     #"
echo "#  Probook = 2                   #"
echo "#  Mirantb = 3                   #"
echo "##################################"

while true; do
    read -r -p " Vyberte 1/2/3: " answer
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
               break;;
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
               break;;
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
               break;;
         * ) echo "Vyberte 1, 2, nebo 3";;
     esac
done
  
echo "####################"
echo "#  Nastavení swap  #"
echo "####################"
echo vm.swappiness=10 | sudo tee /etc/sysctl.d/99-swappiness.conf
echo -e "\n"

echo "#########################"
echo "#  Synology nfs shares  #"
echo "#########################"
echo -e "\n"
sudo mkdir /nfs &&
sudo chmod -R ugo+rwx /nfs
sudo cp -f /home/libor/.dotfiles/autofs/* /etc/autofs/
sudo systemctl enable autofs.service
sleep 4

echo
echo "######################"
echo "#  Nastavuji Greetd  #"
echo "######################"
sudo cp -f ~/.dotfiles/greetd/* /etc/greetd/
sudo systemctl enable greetd.service

mkdir -p Public Templates Stažené Dokumenty Hudba Videa

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
echo "###################################"
echo "#  Add $HOME/.local/bin to $PATH  #"
echo "###################################"
sleep 3
EDITOR=vim sudoedit /etc/profile

echo
echo "#####################"
echo "#  KONEC INSTALACE  #" 
echo "#####################"

##### END OF FILE #####
