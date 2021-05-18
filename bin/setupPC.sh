#!/usr/bin/env bash

set -e

function cfg {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

if cfg checkout 2>/dev/null; then
  echo "Checked out cfg from repo.";
else
  echo "Backing up pre-existing dot files."
  mkdir -p .cfg-backup
  cfg checkout 2>&1 | grep "^\s." | sed 's/^[[:space:]]*//g' | tr '[\n]' '[\0]' | xargs -n1 -r0 /bin/bash -c 'mkdir -p ".cfg-backup/$(dirname $@)"; mv "$@" ".cfg-backup/$@"' ''
  echo "Checked out cfg from repo."
  cfg checkout
fi;

cfg config --local status.showUntrackedFiles no

echo "You need to install:"
echo "  - p4merge --> https://www.perforce.com/downloads/visual-merge-tool und ggf. sudo apt install qt5-default"

