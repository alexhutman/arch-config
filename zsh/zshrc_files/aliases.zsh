#     ___    ___                     
#    /   |  / (_)___ _________  _____
#   / /| | / / / __ `/ ___/ _ \/ ___/
#  / ___ |/ / / /_/ (__  )  __(__  ) 
# /_/  |_/_/_/\__,_/____/\___/____/  


# Nvim aliases
alias vi="nvim"
alias vim="nvim"

# Clear whole screen
alias clear="clear && printf '\e[3J'"

# Git aliases
# NOTE: There are some functions for git in functions.zsh
alias gb="git branch"
alias gco="git checkout"
alias gcm="git commit"
alias gd="git diff"
alias gl="git log"
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias gs="git status"

# Colorize commands when possible. From github/LukeSmithxyz's config
alias \
	ls="ls -hN --color=auto --group-directories-first" \
	grep="grep --color=auto" \
	diff="diff --color=auto"
