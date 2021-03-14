#!/bin/bash

# Add user, set password and name to test
sudo adduser test <<- EOF
	test
	test
	test




	Y
EOF

# Allow user to sudo
sudo usermod -aG sudo test
