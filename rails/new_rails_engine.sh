#!/usr/bin/env bash

# Usage:
# $ bash <(curl https://raw.githubusercontent.com/carpodaster/dotfiles/master/rails/new_rails_engine.sh) ENGINENAME

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

engine_name=$1
rails_version=`rails -v |head -n1 |awk '{print $2}'`

if [[ -z $engine_name ]]; then
  echo "E: Must supply engine name."
  exit 1
fi

if [[ "$rails_version" =~ [0-9] ]]; then
  echo -n "Creating Rails engine \"$engine_name\" using Rails v${rails_version}. Proceed? [Y/n] "
  read proceed
  if [[ "$proceed" =~ ^[nN] ]]; then
    exit 1
  fi
else
  echo "Unrecognized Rails version. Is Rails installed?"
  exit 1
fi

echo "Proceeding"

rails plugin new \
  --skip-javascript \
  --skip-test-unit \
  --skip-bundle \
  --skip-spring \
  --mountable \
  $engine_name

cd $engine_name

# Le git
git init .

# Create gemsets
rvm gemset use $engine_name --create
echo $engine_name >> .ruby-gemset


