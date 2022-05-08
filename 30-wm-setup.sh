#!/bin/bash
#set -e
###############################################################################
# Author	:	Kelly McCuddy
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
#   This script is a work in progress.  The goal of which to get a fresh Arch
#   install setup with the xorg window server so that any WM or DE can be 
#   installed. The package choice is fory my persoal taste. You will need to 
#   edit the package choices for your prefences.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
xorg
xorg-xinit
awesome-terminal-fonts 
ttf-font-awesome
thunar
thunar-archive-plugin
thunar-volman
sxhkd
dmenu
dunst
feh
network-manager-applet
ttf-dejavu 
ttf-liberation
picom
polkit
polkit-gnome
rofi
imagemagick
lxappearance
lxrandr
pipewire
pipewire-alsa
pipewire-pulse
lib32-pipewire
wireplumber
pavucontrol
gstreamer
gst-plugins-good
gst-plugins-bad
gst-plugins-base
gst-plugins-ugly
playerctl
volumeicon
sddm
udisks2
kitty
exa
neofetch
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

# Choice to install Nvidia drivers
while [ true ]
do
    echo "Do you need the Nvidia propretary drivers installed?"
    read -p 'Please type yes or no: ' nvidiavar

    if [ $nvidiavar == 'yes' ]; then
        sudo pacman -S --noconfirm --needed nvidia nvidia-utils nvidia-settings
        break
    elif [ $nvidiavar == 'no' ]; then
        break
    else
        echo "You must type yes or no"
    fi
done

sudo systemctl enable sddm.service

###############################################################################

tput setaf 7;echo "################################################################"
echo "You now have a functional xserver awaiting a Window Manager"
echo "################################################################"
echo;tput sgr0

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
