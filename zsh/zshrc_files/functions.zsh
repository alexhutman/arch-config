#     ______                 __  _                 
#    / ____/_  ______  _____/ /_(_)___  ____  _____
#   / /_  / / / / __ \/ ___/ __/ / __ \/ __ \/ ___/
#  / __/ / /_/ / / / / /__/ /_/ / /_/ / / / (__  ) 
# /_/    \__,_/_/ /_/\___/\__/_/\____/_/ /_/____/  


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


# To start shell in normal mode, not insert mode
zle-line-init() { zle -K vicmd; }
zle -N zle-line-init
