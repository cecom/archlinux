# DEBIAN Install

1. via usb iso installieren, die hybrid variante:https://cdimage.debian.org/images/unofficial/non-free/images-including-firmware/current-live/amd64/iso-hybrid/debian-live-X.X.X-amd64-standard+nonfree.iso
1. sudo apt install networkmanager git
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
1. `nmtui` aufrufen und wlan einrichten
1. XStuff: `sudo apt install xorg xinit nitrogen xmonad dmenu`
1. other stuff: `sudp apt install exa neofetch wget firefox-esr chromium xpad xclip wget curl vim`
1. locale stuff:
   ```sh
   vi /etc/locale.gen
   ... uncomment ...
   de_DE.UTF-8
   ```
1. Locales generieren:`sudo locale-gen`
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
1. st term
   ```sh
   sudo apt install libharfbuzz-bin libharfbuzz-dev
   mkdir tools
   cd tools
   git clone https://github.com/LukeSmithxyz/st
   cd st
   sudo make install
   ```
1. power savings:
   ```sh
   sudo apt install tlp tlp-rdw
   sudo tlp start
   sudo tlp-stat -c
   sudo systemctl status tlp
   ```
1. ssh key generieren
1. x starten mit xmonad in xinitrc
1. alt+p für firefox
1. sshkey vom terminal kopieren, public key vorher markieren: "xclip -o | xclip -selection clipboard -i"
