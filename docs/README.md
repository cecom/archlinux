 # Arch Linux Install

INSTALL.md anschauen fuer neues System

1. Netzwerk: `nmtui` aufrufen und WLAN konfigurieren. Wird durch network-manager nächste mal automatisch geladen
1. x stuff: `pacman -S xorg xorg-xinit nitrogen picom xmonad xmonad-contrib dmenu`
1. other stuff: `pacman -S git exa vivid pacman-contrib neofetch wget firefox chromium xpad`
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
   

