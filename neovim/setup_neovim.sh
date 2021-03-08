#!/usr/bin/env bash

# This script pretty much just does everything from this https://neovim.io/doc/user/nvim.html#nvim-from-vim but automatically
# It also installs VimPlug

# Directory of this file
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Set variable for config folder path
if [ -z "$XDG_CONFIG_HOME" ]
then
	CFG_PATH="~/.config/nvim"
else
	CFG_PATH="$XDG_CONFIG_HOME/nvim"
fi

# Make config directory if it doesn't exist
mkdir -p $CFG_PATH

# Copy init.vim to config folder
cp "$SCRIPT_DIR/init.vim" $CFG_PATH

# Download VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install VimPlug
nvim --headless +PlugInstall +qa
