#!/usr/bin/env bash

set -e

function cfg {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

if cfg checkout 2>/dev/null; then
  echo "Checked out cfg.";
else
  echo "Backing up pre-existing dot files."
  mkdir -p .cfg-backup
  cfg checkout 2>&1 | grep "^\s." | sed 's/^[[:space:]]*//g' | tr '[\n]' '[\0]' | xargs -n1 -r0 /bin/bash -c 'mkdir -p ".cfg-backup/$(dirname $@)"; mv "$@" ".cfg-backup/$@"' ''
  cfg checkout
fi;

cfg config --local status.showUntrackedFiles no
