#!/usr/bin/env bash
brew install git vim bash-completion pwgen imagemagick mutt postgres

echo
echo Postinstall:
echo
echo ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
echo launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
echo 
