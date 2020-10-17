# Arch Linux Install

- Keyboard auf de: `loadkeys de-latin1`
- Größere Schrift: `setfont /usr/share/kbd/consolefonts/ter-v32n.psf.gz`

### wifi
- Variante 1:
  - `iwctl --passphrase PWXXX station wlan0 connect Storm@Home`
- Variante 2: 
  1. `iwctl`
  2. `device list`
  3. `station wlan0 get-networks`
  4. `station wlan0 connect Storm@Home`

### FDISK
1. fdisk /dev/nvme0n1
1. Alle Partitionen löschen: `d`und dann `1` und so weiter
1. EFI Partition anlegen: `g`, `n`,`ENTER`,`ENTER`,`+300M`,`Y`,`t`,`1`
1. Boot Partition: `n`,`ENTER`,`ENTER`,`+500M`
1. LVM Partition: `n`,`ENTER`,`ENTER`,`ENTER`,`t`,`ENTER`,`30`
1. Reboot 
1. Format EFI: `mkfs.fat -F32 /dev/nvme0n1p1`
1. Format BOOT: `mkfs.ext4 /dev/nvme0n1p2`
1. Setup Encryption: `cryptsetup luksFormat /dev/nvme0n1p3`
1. Open Filesystem: `cryptsetup open --type luks /dev/nvme0n1p3 lvm`
1. Create LVM
    ```sh 
    pvcreate --dataalignment 1m /dev/mapper/lvm
    vgcreate volgroup0 /dev/mapper/lvm
    lvcreate -L 50GB     volgroup0 -n lv_root
    lvcreate -L 10GB     volgroup0 -n lv_tmp
    lvcreate -l 100%FREE volgroup0 -n lv_home
    modprobe dm_mod
    vgscan
    vgchange -ay
    ```
1. Format LVM Partitions
    ```sh 
    mkfs.ext4 /dev/volgroup0/lv_root
    mkfs.ext4 /dev/volgroup0/lv_tmp
    mkfs.ext4 /dev/volgroup0/lv_home
    ```
1. Mounting Partitions
    ```sh 
    mount /dev/volgroup0/lv_root /mnt
    mkdir /mnt/boot
    mkdir /mnt/home
    mkdir /mnt/tmp
    mount /dev/nvme0n1p2 /mnt/boot
    mount /dev/volgroup0/lv_home /mnt/home
    mount /dev/volgroup0/lv_tmp /mnt/tmp
    ```
1. Initial system
    ```sh 
     mkdir /mnt/etc
     genfstab -U -p /mnt >> /mnt/etc/fstab
     cat /mnt/etc/fstab
     pacstrap -i /mnt base
    ```
1. Access the in-progress Arch installation: `arch-chroot /mnt`
1. Repo Update: `pacman -Syyy`
1. Install a kernel and headers: `pacman -S linux linux-headers`
1. Install optional packages: `pacman -S base-devel openssh linux-firmware`
1. Install Network stuff: `pacman -S networkmanager wpa_supplicant wireless_tools netctl dialog`
1. Enable Networkmanager: `systemctl enable NetworkManager`
1. Install LVM Support: `pacman -S lvm2`
1. Install Stuff: `pacman -S vim sudo`
1. Edit /etc/mkinitcpio.conf: 
    ```sh
    line #52 add "encrypt lvm2" in between "block" and "filesystems"
    HOOKS=(base udev autodetect modconf block encrypt lvm2 filesystems keyboard fsck)
    ```
1. Create the initial ramdisk for the main kernel: `mkinitcpio -p linux`
1. useradd: `useradd -m -g users -G wheel cecom`
1. passwd: `passwd cecom`
1. sudo for group wheel: `visudo` and uncomment `%wheel ALL=(ALL) ALL`
1. Grub Stuff: `pacman -S grub efibootmgr dosfstools os-prober mtools`
1. Edit Grub Config: `vim /etc/default/grub`
    ```sh
    #uncomment GRUB_ENABLE_CRYPTODISK=y
    GRUB_ENABLE_CRYPTODISK=y
    #add GRUB_CMDLINE_LINUX_DEFAULT 
    GRUB_CMDLINE_LINUX_DEFAULT="cryptdevice=/dev/nvme0n1p3:volgroup0:allow-discards quiet"
    ```
1. EFI Stuff:
    ```sh
    mkdir /boot/EFI
    mount /dev/nvme0n1p1 /boot/EFI
    grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck
    grub-mkconfig -o /boot/grub/grub.cfg
    ```
1. SWAP File: 
    ```sh
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    cp /etc/fstab /etc/fstab.bak
    echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
    ```
1. AMD Stuff: `pacman -S amd-ucode`
1. Other Stuff: `pacman -S xorg-server mesa`
1. German Stuff:
    ```sh
    echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
    ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
    ```
1. Reboot:
    ```sh
    exit
    umount -a
    reboot
    ```
    
### Nachträglich was nachinstallieren
1. von usb booten
1. `iwctl --passphrase PWXXX station wlan0 connect Storm@Home`
1. Open Filesystem: `cryptsetup open --type luks /dev/nvme0n1p3 lvm`
1. Mounting Partitions
    ```sh 
    mount /dev/volgroup0/lv_root /mnt
    mkdir /mnt/boot
    mkdir /mnt/home
    mkdir /mnt/tmp
    mount /dev/nvme0n1p2 /mnt/boot
    mount /dev/volgroup0/lv_home /mnt/home
    mount /dev/volgroup0/lv_tmp /mnt/tmp
    ```
1.  Access the in-progress Arch installation: `arch-chroot /mnt`

### Installation
1. Netzwerk: `nmtui` aufrufen und WLAN konfigurieren. Wird durch network-manager nächste mal automatisch geladen
1. x stuff: `pacman -S xorg xorg-xinit nitrogen picom xmonad xmonad-contrib xmobar dmenu rxvt-unicode `
1. other stuff: `pacman -S git firefox chromium`
1. git projekt clonen und links setzen


 




