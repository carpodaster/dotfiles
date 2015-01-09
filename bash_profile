###  tab completion stuff

# `brew install git-completion` first
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
# source ~/Development/dotfiles/git-completion.bash # w/o brew

# git PS1 w/ cyan coloured branch
export PS1='\h:\W \u \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '

# ubuntu scheme
#export PS1='\u@\h:\w$(__git_ps1 " [\[\e[34;1m\]%s\[\e[0m\]]")\$ '

# coloured output and better readability on black terminal background
export LSCOLORS=hefxcxdxbxegedabagacad
alias ls='ls -G'

# Helper functions for teh lazyness!1
rgrep() {
  directories="app lib spec"
  if [ -d "test" ]; then
    directories="${directories} test"
  fi
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
