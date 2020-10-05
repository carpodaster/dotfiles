# vim:ft=sh:fdm=marker

###  tab completion stuff

# `brew install bash-completion` first
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Get the __git_ps1 function
source ~/Development/dotfiles/git-completion.bash # w/o brew

# Tab-expands mix
if [ -f ~/Development/dotfiles/elixir-completion.bash ]; then
  . ~/Development/dotfiles/elixir-completion.bash
fi

__elixir_ps1() {
  if [[ -f "./mix.exs" ]]; then
    ex_version=$(asdf current elixir |awk -F' ' '{print $1}')
    if [ "$ex_version" = " current" ]; then
      ex_version=""
    fi
    echo "[v${ex_version}] "
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
  # {{{
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
} # }}}

exgrep() {
  # {{{
  directories="web lib config test"
  if [ "$1" == "-l" ]; then
    grep -Rl$3 "$2" $directories $4 $5 $6 $7 $8 |grep -v Binary
  else
    grep -R$2  "$1" $directories $3 $4 $5 $6 $7  |grep -v Binary
  fi
} # }}}

# Open the GH project page, based upon:
# https://dev.to/shayde/open-the-github-project-page-of-a-repo-from-terminal
function GitHub()
{ # {{{
  if [ ! -d .git ]
  then
    echo "E: This isn't a git directory"
    return 1
  fi

  git_url=`git config --get remote.origin.url`
  if [[ $git_url = https://github* ]]
  then
    url=${git_url%.git}
  fi

  if [[ $git_url = git@github* ]]
  then
    git_url=$(echo $git_url | sed -e s/git@/https:\\/\\// -e s/\\.com:/\\.com\\//)
    url=${git_url%.git}
  fi

  if [ "$url" = "" ]
  then
    echo "E: Remote origin is invalid"
    return 1
  fi
  xdg-open $url
}
alias github=GitHub # }}}

alias prettyjson='python -m json.tool'

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

export GPG_TTY=$(tty)

# Command history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

export PATH="/usr/local/bin:$PATH"

test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="/usr/local/sbin:$PATH"
