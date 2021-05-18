#!/usr/bin/env bash

# If not running interactively, don't do anything 
[[ $- != *i* ]] && return

# start zsh instead if exists
hash zsh 2>/dev/null && test -r ${HOME}/.zshrc && exec zsh -di