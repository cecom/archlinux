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
    lvcreate -L 32GB     volgroup0 -n lv_swap
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
    mkswap    /dev/volgroup0/lv_swap
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
    swapon -vs /dev/volgroup0/lv_swap
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
1. locale stuff:
   ```sh
   vim /etc/locale.gen
   ... uncomment ...
   de_DE.UTF-8
   ```
1. Locales generieren:`locale-gen`
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
1. other stuff: `pacman -S git firefox chromium exa vivid pacman-contrib neofetch wget xpad`
1. git projekt clonen und links setzen
1. yay installieren: 
   ```sh
   mkdir tools
   cd tools
   pacman -S --needed git base-devel
   git clone https://aur.archlinux.org/yay.git
   cd yay
   makepkg -si
   ```
1. st terminal installieren: `yay st-luke-git`
1. nerd fonts: `yay nerd-fonts-mononoki`
1. SSH KEY einrichten `ssh-keygen -t ed25519 -a 100 -C "$(whoami)@$(uname -n)-$(date -I)" -f .ssh/$(whoami)@$(uname -n)-$(date -I)` und in Github hinterlegen
1. SSH Keychain: `sudo pacman -S keychain`
1. Environment clonen: `git clone --bare git@github.com:cecom/archlinux.git $HOME/.cfg`
1. Setup Script ausführen: `bin/setupPC.sh`
1. LibreOffice: `sudo pacman -S libreoffice-still libreoffice-still-de hunspell hunspell-de hyphen hyphen-de libmythes mythes-de`
1. Gimp: `sudo pacman -S gimp`
1. Cryptomator: 
   ```sh
   yay fuse2
   yay java-openjfx
   yay cryptomator
   ```
1. Nextcould: `sudo pacman -S nextcloud-client`
1. xmobar installieren:
   ```sh
   cd tools
   git clone https://aur.archlinux.org/xmobar-git.git
   cd xmobar-git
   vim PKGBUILD
   #--flags="..." durch --flags="all_extensions" ersetzen
   makepkg -si  
   ```
1. stuff für xmobar bzw. xmonad:
   ```sh
   pacman -S alsa-utils scrot alsa-oss trayer network-manager-applet volumeicon xdotool
   ```
1. citrix:
   ```sh
   sudo pacman -S ca-certificates libpng12 libxp libjpeg6-turbo libidn11
   yay hdx-realtime-media-engine
   
   #ggf zertifikate hinzufügen
   cd /opt/Citrix/ICAClient/keystore/cacerts/
   sudo cp /etc/ca-certificates/extracted/tls-ca-bundle.pem .
   awk 'BEGIN {c=0;} /BEGIN CERT/{c++} { print > "cert." c ".pem"}' < tls-ca-bundle.pem
   # die ba zertifikate via browser laden (export)
   sudo cp terminal.arbeitsagentur.de /opt/Citrix/ICAClient/keystore/cacerts/terminal.arbeitsagentur.de.pem
   sudo cp Sectigo\ RSA\ Organization\ Validation\ Secure\ Server\ CA /opt/Citrix/ICAClient/keystore/cacerts/sectigo.pem
   sudo openssl rehash /opt/Citrix/ICAClient/keystore/cacerts/
   ```
1. pcmanfm: `sudo pacman -S pcmanfm-gtk3 file-roler`
1. pcmanfm thumbs: `sudo pacman -S tumbler poppler-glib ffmpegthumbnailer freetype2 libgsf raw-thumbnailer evince libgsf`
1. vlc: `sudo pacman -S vlc`
1. spotify: 
   ```sh
   sudo pacman -S libcurl-gnutls
   curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
   yay spotify
   ```
 1. dropbox:
   ```sh
   sudo pacman -S gendesk
   cd downloads
   curl -sS https://linux.dropbox.com/fedora/rpm-public-key.asc | gpg --import -
   yay dropbox
   ```





