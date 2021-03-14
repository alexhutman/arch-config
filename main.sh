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

pad_next_step() {
	printf "\n\n"
}

pkg_mgr_warn() {
	echo "Installing preferred packages. You will likely have to enter your password."
}

echo "Installing necessary packages..."
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
pad_next_step

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
pad_next_step

echo "Copying dotfiles..."
cp $(find dotfiles -name "\.*") ~
pad_next_step

echo "Installing plugins and custom zsh files..."
zsh <<-EOF
SETUP_CONF="YES"
# Source zshrc to get access to $ZSH_CUSTOM
. ~/.zshrc

if [ -z "\$ZSH_CUSTOM" ]
then
	err_and_exit "\\$ZSH_CUSTOM variable is not set, but it should be.."
else
	# Move custom .zsh files
	cp zshrc_files/*.zsh \$ZSH_CUSTOM/

	# TODO: Put this in its own function or file in case I use more plugins in the future. Will be easier to manage.
	# Install zsh-syntax-highlighting plugin
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi
EOF
pad_next_step

echo "Installing Powerline fonts (needed for oh-my-zsh theme) if necessary..."
if grep -q "Microsoft" /proc/version || [ "$(uname)" = "Darwin" ]
then
	read -p "If the zsh prompt looks wonky, you probably have to install these fonts on your host system (if on Mac or Windows). Install them at https://github.com/powerline/fonts. Press enter to acknowledge this: "
else
	git clone https://github.com/powerline/fonts.git --depth=1
	./fonts/install.sh
	rm -rf fonts
fi
pad_next_step

echo "Setting up neovim..."
./neovim/setup_neovim.sh
pad_next_step

echo "Changing shell to zsh. You will likely have to enter your password."
chsh -s "$(which zsh)" && export SHELL="$(which zsh)" || echo "Couldn't change shell to zsh."
pad_next_step

echo "Replacing current shell with zsh..."
exec zsh -l
