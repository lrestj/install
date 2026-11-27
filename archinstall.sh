#!/bin/bash

set -e

cat << 'EOF'

##################################
# Na jaký počítač instalujete?   #
# Zbook = 1                      #
# Probook = 2                    #
# Mirantb = 3                    #
##################################
EOF
while true; do
    read -r -n 1 -p "Vyberte 1/2/3: " answer
    echo ""
    case "$answer" in
        1)
            REPO="zbook"
            cat << 'EOF'

###########################
# Zvolili jste Zbook      #
###########################
EOF
            sleep 4
            break ;;
        2)
            REPO="probook"
            cat << 'EOF'

#############################
# Zvolili jste Probook      #
#############################
EOF
            sleep 4
            break ;;
        3)
            REPO="mirantb"
            cat << 'EOF'

#############################
# Zvolili jste Mirantb      #
#############################
EOF
            sleep 4
            break ;;
        *)
            echo "Vyberte 1, 2, nebo 3" ;;
    esac
done

cat << 'EOF'

##################################################
#  Spouštím instalaci, můžete zrušit CTRL+C ...  #
##################################################
EOF
sleep 4
sudo pacman -Syu --noconfirm \

cat << 'EOF'

#################################
#  Instalace z repozitáře Arch  #
#################################
EOF
sudo pacman -S --noconfirm \
awesome-terminal-fonts baobab brightnessctl btop \
cinnamon-translations cliphist evince \
fastfetch file-roller firewall-applet fish font-manager foot fuzzel fzf \
galculator gcolor3 geany glxinfo gparted grim gvfs hplip jq \
less libreoffice-fresh-cs mako mpv nemo-fileroller \
network-manager-applet niri nfs-utils nwg-look \
p7zip pacman-contrib pamixer papirus-icon-theme pavucontrol pdfarranger python-pyqt5 \
qjackctl qt6ct qutebrowser rclone reflector \
simple-scan swaybg swayidle swaylock \
ttf-hack-nerd ttf-nerd-fonts-symbols udiskie unrar vlc \
waybar wayland-protocols wlsunset \
xdg-desktop-portal-gnome xwayland-satellite xournalpp \
yazi zenity zip 

cat << 'EOF'

###################################
# Probíhá konfigurace $REPO ...   #
###################################
EOF
git clone --bare -b arch "https://github.com/lrestj/${REPO}.git" "$HOME/.cfg.git"
CFG="git --git-dir=$HOME/.cfg.git/ --work-tree=$HOME"
$CFG checkout -f

cat << 'EOF'

###################################
# Konfigurace git repozitářů ...  #
###################################
EOF
cd $HOME
git config --global user.email "rest@seznam.cz"
git config --global user.name "LrestJ"
$CFG remote remove origin
$CFG remote add github "git@github.com:lrestj/${REPO}.git"
$CFG remote add gitlab "git@gitlab.com:lrestj/${REPO}.git"
$CFG remote -v

git clone https://github.com/lrestj/install "$HOME/.dotfiles/install"
cd "$HOME/.dotfiles/install"
git remote remove origin
git remote add github git@github.com:lrestj/install.git
git remote add gitlab git@gitlab.com:lrestj/install.git
git remote -v

cat << 'EOF'

###########################
# Nfs Synology settings   #
###########################
EOF
sudo cp -n /etc/fstab /etc/fstab.bak || true
cat "$HOME/.dotfiles/nfs2fstab.txt" | sudo tee -a /etc/fstab > /dev/null
sudo mkdir -p /nfs/Nas /nfs/FilmyNas /nfs/HudbaNas
mkdir -p "$HOME"/{Dokumenty,Videa,Hudba,Stažené,Templates}

cat << 'EOF'

############################
#  Autologin & swappiness  #
############################
EOF
sudo cp -rf $HOME/.dotfiles/getty@tty1.service.d /etc/systemd/system/
sudo cp -rv /home/libor/.dotfiles/journald.conf.d /etc/systemd/
cd $HOME
mkdir -p Templates Stažené Dokumenty Hudba Videa
echo vm.swappiness=10 | sudo tee /etc/sysctl.d/99-swappiness.conf

cat << 'EOF'

####################################
# Konec instalace                  #
# Restartovat do nového systému?   #
####################################
EOF
while true; do
    read -r -n 1 -p "Vyberte (A/N): " restart_answer
    echo ""
    case "$restart_answer" in
        [Aa]* )
            echo -e "\nRestartuji..."
            sleep 1
            sudo loginctl reboot ;;
        [Nn]* )
            exit 0;;
        * )
            echo -e "\nVyberte A nebo N " ;;
    esac
done

#### END OF FILE #####
