/bin/bash

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

echo "##################################################"
echo "#  Spouštím instalaci, můžete zrušit CTRL+C ...  #"
echo "##################################################"
sleep 4
sudo pacman -Syu --noconfirm \

echo
echo "#################################"
echo "#  Instalace z repozitáře Arch  #"
echo "#################################"
sudo pacman -S --noconfirm \
awesome-terminal-fonts baobab brightnessctl btop \
cinnamon-translations cliphist evince fastfetch fish font-manager foot fuzzel \
galculator gcolor3 geany glxinfo gparted grim gvfs jq \
kitty kwallet-pam kwalletmanager libreoffice-fresh-cs \
mako mpv nemo network-manager-applet niri nwg-look \
p7zip pamixer papirus-icon-theme pdfarranger \
qjackctl qt6ct qutebrowser rclone \
simple-scan swaybg swayidle swaylock \
ttf-hack-nerd ttf-nerd-fonts-symbols udiskie vlc \
waybar wayland-protocols wlsunset \
xdg-desktop-portal-gnome xwayland-satellite xournalpp \
yazi zenity zip 

echo
echo "################################"
echo "#  Instalace z repozitáře Aur  #"
echo "################################"
yay -S --noconfirm bemoji bibata-cursor-theme waypaper xfce-polkit

case $answer in
    [1]* ) echo
           echo "####################################"
           echo "#                                  #"
           echo "#  Probíhá konfigurace Zbook...    #"
           echo "#                                  #"
           echo "####################################"
           git clone --bare -b endeavourOS https://github.com/lrestj/probook.git $HOME/.cfg.git
           git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME checkout -f &&
           echo
           echo "###################################"
           echo "#  Konfigurace git repozitáře...  #"
           echo "###################################"
           git config --global user.email "rest@seznam.cz"
           git config --global user.name "LrestJ"
           git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote remove origin
           git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add github git@github.com:lrestj/zbook.git
           git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote add gitlab git@gitlab.com:lrestj/zbook.git
           git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME remote -v
           ;;
    [2]* ) echo
           echo "######################################"
           echo "#                                    #"
           echo "#  Probíhá konfigurace Probook...    #"
           echo "#                                    #"
           echo "######################################"
           git clone --bare -b endeavourOS https://github.com/lrestj/probook.git $HOME/.cfg.git
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
           git clone --bare -b endeavourOS https://github.com/lrestj/probook.git $HOME/.cfg.git
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
sudo powerprofilesctl set performance

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
echo
echo "####################################"
echo "#  Restartovat do nového systému?  #"
echo "####################################"
while true; do
    read -r -n 1 -p "Vyberte (A/N): " answer
    case $answer in
        [Aa]* ) echo -e "\n Restartuji..."
                sleep 1
                sudo reboot; break;;
        [Nn]* ) exit;;
        * ) echo -e "\nVyberte A nebo N.";;
    esac
done

#### END OF FILE #####
