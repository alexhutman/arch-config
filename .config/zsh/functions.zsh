#     ______                 __  _                 
#    / ____/_  ______  _____/ /_(_)___  ____  _____
#   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
#  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
# /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  


# Git functions
function ga() {
		git add "$@"
		git status
}

function gr() {
		git reset "$@"
		git status
}


# To start shell in normal mode, not insert mode
zle-line-init() { zle -K vicmd; }
zle -N zle-line-init


# Generate headers such as the one you see above
function headergen() {
	command -v figlet > /dev/null 2>&1
	if [[ "$?" -ne "0" ]] 
	then
		echo "You do not have figlet. Please install figlet using whichever package manager you have on your machine."
	elif [[ "$#" -ne "1" ]]
	then
		echo "Please only enter the string of the header (surrounded in double quotes) to be echoed."
	else
		figlet -f slant "$1" | sed '/^\s*$/d; s/^/# /g' | sed '$ G; $ G'
	fi
}


# Unalias aliases from the git plugin
function rmgitaliases()  {
		git_plugin_dir="$ZSH/plugins/git/git.plugin.zsh"

		if [[ -f "$git_plugin_dir" ]] 																		 # If git plugin isn't found, don't do anything
		then						  																		 # Otherwise,
				aliases_rm_cmd="sed -nE '/alias\s+/s/.*([&|\s]?)+alias\s*([^=]*)=.*/\2/p' $git_plugin_dir"	 # Grab all of the aliases that the plugin uses
				alias_count=$(sed -n '/^\s*[^#].*/p' $ZSH/plugins/git/git.plugin.zsh | grep "alias" | wc -l) # Find out how many there are so we can make sure we unalias all of them
		
				if [[ $(eval $aliases_rm_cmd | wc -l) -ne $alias_count ]]									 # Make sure the counts are equal
				then
						echo "You're terrible at sed, Alex. Please fix me."
				else
						for git_alias in $(eval $aliases_rm_cmd)											 # Unalias all of them
						do
							unalias "$git_alias" 2>/dev/null
						done
				fi
		else
				echo "Your git plugin file is not in $ZSH/plugins/git/git.plugin.zsh"
		fi
}

# The following is from https://stackoverflow.com/a/2342841/6708303
# It allows you to treat only stdout as stdin. Just keeping it here for reference.
# command 2>&1 >/dev/null | grep 'something' 

function gitAddExcept() {
	gs | sed -n '/modified/p' | awk '{ print $2 }' | grep -vP "$1"
}
