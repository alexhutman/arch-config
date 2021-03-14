#!/bin/bash

# First parameter is the user's name, defaults to "test"
[ -z "$1" ] && NEW_USER="test" || NEW_USER="$1"

# Add user, set password to "test" and name to supplied user name
sudo adduser "$NEW_USER" <<- EOF
	test
	test
	$NEW_USER




	Y
EOF

# Allow user to sudo
sudo usermod -aG sudo "$NEW_USER"
