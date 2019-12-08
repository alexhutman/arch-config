#!/usr/bin/zsh

# This script pretty much just does everything from this https://neovim.io/doc/user/nvim.html#nvim-from-vim but automatically

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Run neovim script that outputs the config directory to a temporary file called "name_of_config_file"
sed "s|{SCRIPT_PATH}|$SCRIPT_DIR|g" "$SCRIPT_DIR/output_config_dir_template.vim" > "$SCRIPT_DIR/output_config_dir.vim"
nvim +"so $SCRIPT_DIR/output_config_dir.vim"
rm "$SCRIPT_DIR/output_config_dir.vim"

# Get rid of the blank lines produced by neovim (not sure why that happens)
sed -i '/^$/d' "$SCRIPT_DIR/name_of_config_file"

# Set variable for config dir path
CFG_PATH="$(cat $SCRIPT_DIR/name_of_config_file)"

# Remove the temporary file
rm name_of_config_file

# Make config directory
mkdir -p "$CFG_PATH"

# Copy init.vim to config folder
cp "$SCRIPT_DIR/init.vim" "$CFG_PATH"

# Copy .vimrc to ~
cp "$SCRIPT_DIR/.vimrc" ~
