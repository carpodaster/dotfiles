###  tab completion stuff

# `brew install git-completion` first
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# source ~/Development/dotfiles/git-completion.bash # w/o brew

# Tab-expands mix
if [ -f ~/Development/dotfiles/elixir-completion.bash ]; then
  . ~/Development/dotfiles/elixir-completion.bash
fi

__elixir_ps1() {
  if [[ -f "./mix.exs" ]]; then
    ex_version=$(kiex list |grep '='|head -n1 |awk -F- '{print $2}')
    if [ "$ex_version" = " current" ]; then
      ex_version=""
    fi
    # ex_version=$(elixir --version| tail -n1 |awk  '{print $2}')
    echo "[Elixir v${ex_version}] "
  fi
}

# git PS1 w/ cyan coloured branch
# export PS1='\h:\W \u \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '
export PS1='\h:\W \u \[\033[38;5;140m\]$(__elixir_ps1)\[\033[0m\]\[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '

# ubuntu scheme
#export PS1='\u@\h:\w$(__git_ps1 " [\[\e[34;1m\]%s\[\e[0m\]]")\$ '
# New Ubuntu scheme (16.04 LTS)
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " [\[\e[36;1m\]%s\[\e[0m\]] ")\$ '

# coloured output and better readability on black terminal background
export LSCOLORS=hefxcxdxbxegedabagacad

uname=$(uname)
if [ "$uname" = "Linux" ]; then
  alias ls="ls --color --group-directories-first"
elif [ -e `which gls` ]; then
  alias ls="gls --color --group-directories-first"
else
  alias ls='ls -G'
fi

# Helper functions for teh lazyness!1
rgrep() {
  directories="app lib config"
  if [ -d "test" ]; then
    directories="${directories} test"
  fi
  if [ -d "spec" ]; then
    directories="${directories} spec"
  fi
  if [ "$1" == "-l" ]; then
    grep -Rl$3 "$2" $directories $4 $5 $6 $7 $8 |grep -v Binary
  else
    grep -R$2  "$1" $directories $3 $4 $5 $6 $7  |grep -v Binary
  fi
}

exgrep() {
  directories="web lib config test"
  if [ "$1" == "-l" ]; then
    grep -Rl$3 "$2" $directories $4 $5 $6 $7 $8 |grep -v Binary
  else
    grep -R$2  "$1" $directories $3 $4 $5 $6 $7  |grep -v Binary
  fi
}

production_console() {
  heroku run rails console -r production
}

generate_password() {
  pwgen -n -c -1 -s -y $1
}

# Deletes all leftofter Vim .swp files in all subdirectories
clrswp() {
  find . -name \*.sw? -delete
}

gemsetisfy() {
  local gemset=$(basename $(pwd))
  rvm gemset use 2.3.1@${gemset} --create
}
