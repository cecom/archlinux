#todo:
  - update count ubuntu nach neofetch
  - update commando in bin
  - tmux

# Install Windows

1. msys installieren
1. msys starten
1. pacman -Syu
1. pacman -Sy
1. pacman -Sy openssh git 
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
1. *Initial Setup* ausführen

# Initial Setup (sowohl Windows als auch Linux)
1. SSH-KEY anlegen 
```
mkdir -p .ssh
export SSH_NAME=$(whoami | tr '[:upper:]' '[:lower:]')
export SSH_MACHINE=$(uname -n | tr '[:upper:]' '[:lower:]')-$(date -I)
ssh-keygen -t ed25519 -a 100 -C "${SSH_NAME}@${SSH_MACHINE}" -f .ssh/${SSH_NAME}@${SSH_MACHINE}

echo "IdentityFile ~/.ssh/${SSH_NAME}@${SSH_MACHINE}" > .ssh/myLocalIdentityFile
```
1. public key in github hinterlegen
1. Intial setup
   ```
   GIT_SSH_COMMAND="ssh -i ~/.ssh/${SSH_NAME}@${SSH_MACHINE} -o IdentitiesOnly=yes" git clone --bare git@github.com:cecom/MyDevEnv.git $HOME/.cfg
   
   git --git-dir=$HOME/.cfg/ show master:bin/myEnv/setupPC.sh | /bin/bash
   ```
1. neu einlogen.

