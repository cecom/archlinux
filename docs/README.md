 # Arch Linux Install

INSTALL.md anschauen fuer neues System

1. Netzwerk: `nmtui` aufrufen und WLAN konfigurieren. Wird durch network-manager nächste mal automatisch geladen
1. x stuff: `pacman -S xorg xorg-xinit nitrogen picom xmonad xmonad-contrib dmenu`
1. other stuff: `pacman -S git neofetch wget firefox chromium`
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
1. nerd fonts: 
   ```sh
   #weil download zu groß, muss es anders installiert werden
   mkdir downloads
   cd ~/downloads
   git clone https://aur.archlinux.org/nerd-fonts-complete.git
   cd nerd-fonts-complete
   curl https://aur.archlinux.org/cgit/aur.git/plain/fix-installer-font-dir.patch?h=nerd-fonts-complete | git apply -
   ```
   Patch in download.patch kopieren: 
   <details>
   <summary>PATCH</summary>
   <p>
   
   ```
   diff --git a/PKGBUILD b/PKGBUILD
   index 8f26a66..240497a 100644
   --- a/PKGBUILD
   +++ b/PKGBUILD
   @@ -15,13 +15,13 @@ depends=('fontconfig' 'xorg-font-utils')
    conflicts=('nerd-fonts-git' 'nerd-fonts-complete-mono-glyphs')
    source=(
      'fix-installer-font-dir.patch'
   -  "${_gitname}-${pkgver}.tar.gz::https://github.com/ryanoasis/nerd-fonts/archive/v${pkgver}.tar.gz"
    )
   -sha256sums=('ccf93b108044a87bfb29c3f836d2ce4d5bdb1829702e532a69ccb4ab4aecaceb'
   -            'a084ca91a174b547bab4523507824c76aa91ebcf38f9256a4ffd181813f87bd8')
   +sha256sums=('ccf93b108044a87bfb29c3f836d2ce4d5bdb1829702e532a69ccb4ab4aecaceb')
   
    prepare () {
   -  cd "$srcdir/$_gitname-$pkgver"
   +  cd "$srcdir"
   +  git clone --branch v${pkgver} --depth 1 https://github.com/ryanoasis/nerd-fonts.git "$_gitname-$pkgver"
   +  cd "$_gitname-$pkgver"
   
      patch -Np1 -i "$srcdir"/fix-installer-font-dir.patch
    }
   ```
   
   </p>
   </details>  
   
   
   ```sh
   git apply download.patch
   makepkg -si
   ```
1. SSH KEY einrichten `ssh-keygen -t ed25519 -a 100` und in Github hinterlegen
1. Environment clonen: `git clone --bare git@github.com:cecom/archlinux.git $HOME/.cfg`
1. Setup Script ausführen: `bin/setupPC.sh`
1. LibreOffice: `sudo pacman -S libreoffice-still libreoffice-still-de hunspell hunspell-de hyphen hyphen-de libmythes mythes-de`
1. Cryptomator: 
   ```sh
   yay fuse2
   yay java-openjfx
   yay cryptomator
   ```
1. Nextcould: `sudo pacman -S nextcloud-client`
1. polybar install: 
   ```sh
   cd downloads
   git clone https://aur.archlinux.org/polybar.git
   cd polybar
   makepkg -si
   ```
