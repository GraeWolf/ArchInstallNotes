# ArchInstallNotes

## Connect to the Internet

  `# iplink set wlp2s0 up`

  First try NetworkManager

  `# pacman -S install networkmanager`

  Try:

  `# nmtui`

  If that doesn't work try:

  `# nmcli device wifi connect Starfleet password sfPass`

  Check to see if iwd is installed. If not then do:

  `# pacman -S install iwd`

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
  
  # pacstrap /mnt base linux linux-firmware networkmanager nano man info
  
  
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
    uncomment 
    
