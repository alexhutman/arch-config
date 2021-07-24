# Enable colors
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
stty stop undef

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history
setopt sharehistory

unsetopt PROMPT_SP

# Load aliases
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Use menu for selecting/tabbing
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include dotfiles in globs
_comp_options+=(globdots)

# Load zsh-specific bindings, functions
[ -f "${ZDOTDIR}/bindings.zsh" ] && source "${ZDOTDIR}/bindings.zsh" 
[ -f "${ZDOTDIR}/functions.zsh" ] && source "${ZDOTDIR}/functions.zsh" 

# This should always be last
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
