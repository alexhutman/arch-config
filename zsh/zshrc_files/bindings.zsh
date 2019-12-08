#     ____  _           ___                 
#    / __ )(_)___  ____/ (_)___  ____ ______
#   / __  / / __ \/ __  / / __ \/ __ `/ ___/
#  / /_/ / / / / / /_/ / / / / / /_/ (__  ) 
# /_____/_/_/ /_/\__,_/_/_/ /_/\__, /____/  
#                             /____/        

# Set vim bindings for zsh
bindkey -v

# Bind Ctrl+K to go forwards (and Ctrl+J to go backwards in the shell history.
# k and j still search forwards/backwards in the history as normal (in normal mode), 
# but in insert mode, Ctrl+J and Ctrl+K go forwards and backwards in the history with 
# respect to the current command in the buffer.
bindkey "^K" history-beginning-search-backward
bindkey "^J" history-beginning-search-forward
