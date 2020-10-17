#!/usr/bin/env bash

git clone --bare git@github.com:cecom/archlinux.git $HOME/.cfg

function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

config checkout

if [ $? = 0 ]; then
  echo "Checked out config.";
else
  mkdir -p .config-backup
  echo "Backing up pre-existing dot files.";
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;

config checkout
config config --local status.showUntrackedFiles no
