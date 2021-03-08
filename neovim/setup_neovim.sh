#!/usr/bin/env sh

# This script pretty much just does everything from this https://neovim.io/doc/user/nvim.html#nvim-from-vim but automatically
# It also installs VimPlug. It is run from <root>/main.sh so running it directly might not work because of the cp line

# Set variable for config folder path
if [ -z "$XDG_CONFIG_HOME" ]
then
	CFG_PATH="$HOME/.config/nvim"
else
	CFG_PATH="$XDG_CONFIG_HOME/nvim"
fi

# Make config directory if it doesn't exist
mkdir -p $CFG_PATH

# Copy init.vim to config folder
cp neovim/init.vim $CFG_PATH

# Download VimPlug
curl -fsSLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install VimPlug
nvim --headless +PlugInstall +qa
