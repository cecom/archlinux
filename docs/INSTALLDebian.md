# DEBIAN Install

todo: 
- script.sh
- powertop
- keyring funktioniert nicht (nextcloud passwort jedesmal)
- 

#faq
- welche taste ist was
  https://superuser.com/questions/389737/how-do-you-make-volume-keys-and-mute-key-work-in-xmonad


1. via usb iso installieren, die hybrid variante:https://cdimage.debian.org/images/unofficial/non-free/images-including-firmware/current-live/amd64/iso-hybrid/debian-live-X.X.X-amd64-standard+nonfree.iso
1. git: `sudo apt install git`
1. linux-firmware:
   ```sh
   git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
   cd linux-firmware/
   # firmware-amd-graphics
   sudo cp -va amdgpu/ /lib/firmware/
   # firmware-iwlwifi
   sudo cp -va iwlwifi-* /lib/firmware/ && sudo cp -va intel/ibt-* /lib/firmware/intel/
   sudo update-initramfs -u
   cd /lib/firmware/
   sudo chown -R root:root amdgpu iwlwifi-* intel/ibt-* 
   ```
1. kernel 5.8 aus backport einspielen und rebooten:
   ```sh
   sudo vi /etc/apt/sources.list
     adding:
     #backport
     deb http://deb.debian.org/debian buster-backports main
   sudo apt update
   sudo apt search linux-image | grep buster-backports
   sudo apt install linux-image-5.8.0-0.bpo.2-amd64
   sudo apt install linux-headers-5.8.0-0.bpo.2-amd64
   ```
1. Netzwerk:
   ```sh
   sudo apt install networkmanager
   nmtui
   ```
1. locale stuff:
   ```sh
   vi /etc/locale.gen
     ... uncomment ...
     de_DE.UTF-8
   
   sudo locale-gen
   ```
1. XStuff: `sudo apt install xorg xinit nitrogen xmonad dmenu firefox chromium htop`
1. st term
   ```sh
   sudo apt install libharfbuzz-bin libharfbuzz-dev
   mkdir tools
   cd tools
   git clone https://github.com/LukeSmithxyz/st
   cd st
   sudo make install
   ```
1. xmonad starten: `xmonad`
1. terminal: `alt+return`
1. chromium: `alt+p + chromium`
1. auf github projekt gehen
1. ssh key generieren: `ssh-keygen -t ed25519 -a 100 -C "$(whoami)@$(uname -n)-$(date -I)" -f .ssh/$(whoami)@$(uname -n)-$(date -I)`
1. auf github hinterlegen
1. env setup:
   ```sh
   git clone --bare git@github.com:cecom/archlinux.git $HOME/.soenv`
   ```
1. Setup Script ausführen: `bin/setupPC.sh`
1. SSH Keychain: `sudo pacman -S keychain`
1. other stuff: 
   ```sh
   sudo apt install \
    exa  #ls ersatz \
    neofetch #übersicht bei bash start \ 
    wget curl vim firefox-esr chromium \
    xpad # notizen\
   ```
1. picom (transparenz):
   ```sh
   sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
   cd tools
   git clone git@github.com:yshui/picom.git
   cd picom
   git submodule update --init --recursive
   meson --buildtype=release . build
   sudo ninja -C build install
   ```
1. power savings:
   ```sh
   sudo apt install tlp tlp-rdw
   sudo tlp start
   sudo tlp-stat -c
   sudo systemctl status tlp
   ```

# screensaver
1. sudo apt install xscreensaver xscreensaver-data xscreensaver-data-extra xscreensaver-gl xscreensaver-gl-extra rss-glx 

#trayer and killall
1. sudo apt install trayer psmisc

#cryptomator
1. sudo apt-get install fuse
1. app image von cryptomator runterladen
1. chmod +x cryptomator-1.5.12-x86_64.AppImage
1. Downloads/cryptomator-1.5.12-x86_64.AppImage  

#keyring
1. sudo apt install gnome-keyring libpam-gnome-keyring libsecret-tools

# nextcloud
1. sudo apt install nextcloud-desktop
1. nextcloud

# citrix
1. https://www.citrix.com/de-de/downloads/workspace-app/linux/workspace-app-for-linux-latest.html
1. sudo apt install ./Downloads/icaclient_21.1.0.14_amd64.deb
1. sudo apt install ./Downloads/ctxusb_21.1.0.14_amd64.deb
1. in chrome auf ica.sdst.sbaintern.de gehen
1. zertifikat via chrome exportieren
1. folgendes fÃr die komplette chain machen (jedes einzeln):
   1. terminal.arbeitsagentur.de anklicken -> export -> base64 singel cert
   1. cd /opt/Citrix/ICAClient/keystore/cacerts
   1. sudo cp ~/Downloads/terminal.arbeitsagentur.de terminal.arbeitsagentur.de.cer
1. sudo openssl rehash /opt/Citrix/ICAClient/keystore/cacerts/
1. sudo vi /etc/icaclient/config/All_Regions.iniï»¿ 
   - TransparentKeyPassthï»¿roughï»¿ï»¿=Remote 

# sound
1. sudo apt install pipewire pipewire-audio-client-libraries libspa-ffmpeg libspa-bluetooth pulseaudio pavucontrol
1. reboot system
1. pactl info 
1. pavucontrol
1. 

# spotify
1. curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
1. echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
1. sudo apt-get update && sudo apt-get install spotify-client

# virtualbox
1. wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
1. echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
1. sudo apt update
1. sudo apt install virtualbox-6.1

#sublime
1. wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
1. sudo apt-get install apt-transport-https
1. echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
1. sudo apt-get update
1. sudo apt-get install sublime-text
1. subl
