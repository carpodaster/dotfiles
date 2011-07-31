source ~/Development/dotfiles/git-completion.bash

# git PS1 w/ cyan coloured branch
export PS1='\h:\W \u \[\033[0;36m\]$(__git_ps1 "[%s] ")\[\033[0m\]\$ '

# coloured output and better readability on black terminal backgrouns
export LSCOLORS=hefxcxdxbxegedabagacad
alias ls='ls -G'
