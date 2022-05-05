#!/bin/bash
#set -e
###############################################################################
# Author	:	Kelly McCuddy
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
#   This is a work in progress.  Some choices the script will ask for input,
#   others you will need to edit this script with your choices. For now those
#   are:
#   Timezone
#   The line number of your locale in locale.gen if it isn't english
#   The LANG variable
#   Your country for the mirrorlist
#   Which shell to use
#
#
#   This is a script I use to help make the install of a base Arch Linux system
#   and prepare it for installing any WM or DE of choice in another script.
#
###############################################################################


# Function to ask user to set a password for the root account and user account
create_pass () {
    while [ true ]
    do
        echo "Please enter a password for $1 :"
        read -sp 'Password: ' passvar1
        echo "Please re-enter the password for $1 :"
        read -sp 'Password: ' passvar2


        
        if [ -z $passvar1 ] || [ -z $passvar2 ]
        then
            echo "Password cannot be blank"
            echo ""
            echo ""
            echo ""
            
        elif [ $passvar1 == $passvar2 ]
        then
            echo $1:$passvar1 | chpasswd
            break
        
        else
            echo "passwords did not match."
            echo ""
            echo ""
            echo ""
        fi
    done
}

# Set your preferred timezone
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime

# Run hwclock(8) to generate /etc/adjtime
hwclock --systohc

# remove the hash sign before the en_US.UTF-8 entry
sed -i '178s/.//' /etc/locale.gen

# Generate locales
locale-gen

# Create locale.conf and set the LANG variable
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set the hostname of the computer
read -p 'Please enter a hostname: ' hostvar
echo "$hostvar" >> /etc/hostname

# Setup local hostname resolution
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostvar.localdomain beowolf" >> /etc/hosts

# Set the root password
create_pass root

# Update the mirrorlist for pacman
reflector -f 10 --country 'United States' --protocol https --sort rate --save /etc/pacman.d/mirrorlist 

# Installing bootloader package and other useful packages
pacman -S --noconfirm grub efibootmgr dialog iwd mtools dosfstools reflector linux-headers xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils bash-completion zsh zsh-completions openssh rsync flatpak os-prober ntfs-3g udiskie terminus-font networkmanager

# Removing the hash in grub settings to use os-prober
sed -i '63s/.//' /etc/default/grub

#installing grub to use uefi
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH --removable
grub-mkconfig -o /boot/grub/grub.cfg

# Enable some services
systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
#systemctl enable firewalld

# Create user
read -p 'Please enter your username: ' uservar
useradd -m $uservar
usermod -aG wheel -s /bin/zsh $uservar

# Set password for user
create_pass $uservar

# Adding user to sudoers to be able to use sudo
echo "$uservar ALL=(ALL) ALL" >> /etc/sudoers.d/$uservar

# placeholder for code to disable root


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
