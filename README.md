# Arch Install Notes

## Connect to the Internet

  `# iplink set wlp2s0 up`

  First try NetworkManager

  `# pacman -S networkmanager`

  Try:

  `# nmtui`

  If that doesn't work try:

  `# nmcli device wifi connect Starfleet password sfPass`

  Check to see if iwd is installed. If not then do:

  `# pacman -S iwd`

  `# iwctl --passphrase sfPass station wlp2s0 connect Starfleet`
  
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
  
  `# pacstrap /mnt base linux linux-firmware networkmanager nano man info`
  
  
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
    
    # pacman -S network-manager-applet
    
  ### Set Root Password
    # passwd
    
  ### Boot Loader
    # pacman -S grub efibootmgr os-prober intel-ucode
    # grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch
    # grub-mkconfig -o /boot/grub/grub.cfg
    
  ### Setup User
    # useradd -m -G wheel -s /bin/bash graewolf
    
# Reboot
  ```
  # exit
  # umount -R /mnt
  # reboot
  ```
