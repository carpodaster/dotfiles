#!/usr/bin/env bash

brew update             && \
brew tap nviennot/tmate && \
brew install tmate

brew install git vim bash-completion pwgen imagemagick mutt postgres elinks gnupg ffmpeg


echo
echo Postinstall:
echo
echo ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
echo launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
echo 
