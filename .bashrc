#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#our config alias
alias config='/usr/bin/git --git-dir=/home/cecom/.cfg/ --work-tree=/home/cecom'
