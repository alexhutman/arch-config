#!/usr/bin/zsh

# This script pretty much just does everything from this https://neovim.io/doc/user/nvim.html#nvim-from-vim but automatically

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Run neovim script that outputs the config directory to a temporary file called "name_of_config_file"

# Set variable for config folder path
CFG_PATH="$(echo ~)/.config/nvim"

# Make config directory
mkdir -p "$CFG_PATH"

# Copy init.vim to config folder
cp "$SCRIPT_DIR/init.vim" "$CFG_PATH"

# Copy .vimrc to ~
cp "$SCRIPT_DIR/.vimrc" ~
