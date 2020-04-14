# Arch Install Notes

## Connect to the Internet

  `# pacman -S iwd`

  `# iwctl --passphrase sfPass station wlan0 connect Starfleet`
  `# dhcpcd`
  
## Update the system clock

  `# timedatectl set-ntp true`
  
## Format Drive Partitions
  ```
  # mkswap /dev/sdb1
  # swapon /dev/sdb1
  # mkfs.ext4 /dev/sdb2
  # mkfs.ext4 /dev/sdb3
  ```
  
## Mount File Systems

  ```
  # mount /dev/sdb2 /mnt
  # mkdir -p /mnt/boot/efi
  # mount /dev/sda1 /mnt/boot/efi
  # mkdir /mnt/home
  # mount /dev/sdb3 /mnt/home
  ```
  
## Install Essential Packages
  
  `# pacstrap /mnt base base-devel linux linux-firmware networkmanager nano man `
  
  
## Configure The System

  ### Fstab
    
    # genfstab -U /mnt >> /mnt/etc/fstab
    
  ### Chroot
    
    # arch-chroot /mnt
    
    
  ### Time Zone
    
    # ln -sf /usr/share/zoneinfo/ETC /etc/localtime 
    
    need to double check this
    
    # hwclock --systohc
    
  ### Localization
    # nano /etc/locale.gen
    uncomment en_US.UTF-8 UTF-8
    # locale-gen
    
    # nano /etc/locale.conf
    LANG=en_US.UTF-8
    
  ### NetWork Configuration
    # nano /etc/hostname
    beowulf
    
    # nano /etc/hosts
    127.0.0.1     localhost
    ::1           localhost
    127.0.0.1     beowulf.localdomain  beowulf
    
    # pacman -S networkmanager
    # systemctl enable NetworManager.service
    # systemctl start NetworkManager.service
    
  ### Set Root Password
    # passwd
    
  ### Boot Loader
    # pacman -S grub efibootmgr os-prober intel-ucode
    # grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
    # grub-mkconfig -o /boot/grub/grub.cfg
    
  ### Setup User
    # useradd -m -G wheel -s /bin/bash graewolf
    # passwd username
    # pacman -S sudo
    # EDITOR=nano visudo
    
  ### Misc
    # nano /etc/pacman.conf
    uncomment multilib section
    # pacman -Syu
    # pacman -S git xdg-user-dirs
    
    
# Reboot
  ```
  # exit
  # umount -R /mnt
  # reboot
  ```

# Setup New System
  run setup.sh
  ```
  $ git clone https://aur.archlinux.org/yay.git
  $ cd yay
  $ makepkg -si
  $ sudo systemctl enable lightdm.service
  $ mkdir -p ~/.config/openbox
  $ cp -a /etc/xdg/openbox/. ~/.config/openbox/
  
  
