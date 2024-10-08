# vim:ft=sh:fdm=marker

###  tab completion stuff

# `brew install bash-completion` first
if [ "$(uname -o)" != "GNU/Linux" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
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

# Usage: `gbr feature Holy Cow What A Feature`
# … will create a branch "feature/holy-cow-what-a-feature"
gbr() {
  local branchname=$(echo -n ${@:2}|tr ' ' '-' |tr '[:upper:]' '[:lower:]')
  git checkout -b "$1/${branchname}"
}

# git PS1 w/ cyan coloured branch
# export PS1='\h:\W \u \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '
export PS1='\h:\W \u \[\033[38;5;140m\]$(__elixir_ps1)\[\033[0m\]\[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '
# Powerline-enabled:
export PROMPT_DIRTRIM=2
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[38;5;140m\]$(__elixir_ps1)\[\033[0m\]\[\033[0;36m\]$(__git_ps1 "[ %s] ")\[\033[0m\] '

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

generate_password() {
  pwgen -n -c -1 -s -y $1
}

# Deletes all leftofter Vim .swp files in all subdirectories
clrswp() {
  find . -name \*.sw? -delete
}

export GPG_TTY=$(tty)

# Command history in iex
export ERL_AFLAGS="-kernel shell_history enabled"

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
