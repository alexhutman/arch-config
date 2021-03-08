#!/bin/sh

UTILS_FNAME="utils.txt"

check_brew_install() {
	if ! command -v brew;
	then
		echo "You don't have homebrew. Installing it."
		# Yeah, there's a dependency on curl and bash but pretty sure Mac comes with them
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		return $?
	else
		return 0
	fi
}

check_pkg_mgrs() {
	for MGR in apt yum snap pacman;
	do
		if command -v $MGR;
		then
			PKG_MGR="$MGR"
		fi
	done
}

err_and_exit() {
	echo "$1. Exiting."
	exit 1
}

pkg_mgr_warn() {
	echo "Installing preferred packages. You will likely have to enter your password."
}

UNAME="$(uname -s)" 
if [ "$UNAME" = "Darwin" ]
then
	check_brew_install || err_and_exit "Couldn't install brew"
elif [ "$UNAME" = "Linux" ]
then
	check_pkg_mgrs

	[ -f "$UTILS_FNAME" ] || err_and_exit "$UTILS_FNAME doesn't exist"

	case $PKG_MGR in
		apt )
			pkg_mgr_warn
			grep -vE '^#' $UTILS_FNAME | xargs sudo apt install -y
			;;
		yum )
			pkg_mgr_warn
			grep -vE '^#' $UTILS_FNAME | xargs sudo yum install -y
			;;
		snap )
			pkg_mgr_warn
			grep -vE '^#' $UTILS_FNAME | xargs sudo snap install
			;;
		pacman )
			pkg_mgr_warn
			grep -vE '^#' $UTILS_FNAME | xargs sudo pacman -Syu
			;;
		* )
			err_and_exit "You do not have a recognized package manager installed"
			;;
	esac
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ -z "$ZSH_CUSTOM" ]
then
	err_and_exit "\$ZSH_CUSTOM variable is not set, but it should be.."
else
	# Move custom .zsh files
	cp zshrc_files/*.zsh $ZSH_CUSTOM/

	# TODO: Put this in its own function or file in case I use more plugins in the future. Will be easier to manage.
	# Install zsh-syntax-highlighting plugin
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Move dotfiles
mv dotfiles/* ~

# Install PowerLine fonts (needed for oh-my-zsh theme)
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts
read -p "You probably have to switch to a PowerLine font in your terminal. If you don't, the oh-my-zsh theme will look wonky. Press enter to acknowledge this."

# Setup neovim
./neovim/setup_neovim.sh

echo "Changing shell to zsh. You will likely have to enter your password."
chsh -s "$(which zsh)" && export SHELL="$(which zsh)" || echo "Couldn't change shell to zsh."

# Unset variables used in this script (since you're supposed to source it)
unset UTILS_FNAME

# Replace current shell with zsh
exec zsh -l
