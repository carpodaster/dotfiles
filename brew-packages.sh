#!/usr/bin/env bash

brew install git vim bash-completion pwgen imagemagick mutt elinks gnupg ffmpeg coreutils \
  pbzip2 ctags bash htop jq colordiff coreutils postgresql@10 redis todo-txt


echo
echo Postinstall:
echo
echo brew services start postgresql
echo
