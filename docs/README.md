 # Arch Linux Install

INSTALL.md anschauen fuer neues System

1. Netzwerk: `nmtui` aufrufen und WLAN konfigurieren. Wird durch network-manager nächste mal automatisch geladen
1. x stuff: `pacman -S xorg xorg-xinit nitrogen picom xmonad xmonad-contrib dmenu`
1. other stuff: `pacman -S git exa pacman-contrib neofetch wget firefox chromium`
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
1. SSH KEY einrichten `ssh-keygen -t ed25519 -a 100` und in Github hinterlegen
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
   cd downloads
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
1. dmenu installieren
