#todo:
- ssh agent auf maschine

# Install Windows

1. msys installieren
1. msys starten
1. pacman -Sy git vim curl tar unrar zsh socat
1. im cmd als admin C:\msys64\home\cecom:
   - `mklink /D .ssh z:\.ssh`
   - `mklink /D .m2 z:\.m2`
   - `mklink /D projekte C:\cecom\projekte`
1. *Initial Setup* ausführen
1. powershell prompt anpassen, powershell starten:
   ```sh
   Test-Path $profile #when true liefert, gibt es schon ein profil unter: ...\Eigene Dateien\WindowsPowerShell
   #when false dann neu anlegen mit:
   New-Item -path $profile -type file –force
   #der path wird ausgegeben, dahin navigieren und öffnen
   #den inhalt von .config/powershell/Microsoft.PowerShell_profile.ps1 reinkopieren
   #prfile reloaden
   . $profile
   ```
1. Visual Studio Code auf msys2 termin umstellen:
   ```sh
   #visual studio code starten
   #File -> Preference -> Settings öffnen und nach terminal.integrated.shell.windows suchen
   #edit json und folgendes einfügen
   "terminal.integrated.shell.windows": "C:\\msys64\\msys2_shell.cmd",
   "terminal.integrated.shellArgs.windows": ["-defterm", "-mingw64", "-no-start", "-here"]
   "terminal.integrated.fontFamily": "mononoki NF"
   ```

# Install Linux
1. mkdir .ssh
1. ssh-keygen -t ed25519 -a 100 -C "$(whoami)@$(uname -n)-$(date -I)" -f .ssh/$(whoami)@$(uname -n)-$(date -I)
1. public key in github hinterlegen
1. .ssh/config anlegen und private key hinterlegen: 
   ```
   CanonicalizeHostname yes
   AddKeysToAgent yes
 
   IdentityFile ~/.ssh/<XXXsshKey>
   ```
1. *Initial Setup* ausführen

# Initial Setup (sowohl Windows als auch Linux)
1. Intial setup
   ```
   git clone --bare git@github.com:cecom/archlinux.git $HOME/.cfg
   git --git-dir=$HOME/.cfg/ show master:bin/setupPC.sh | /bin/bash
   ```
1. neu einlogen.

