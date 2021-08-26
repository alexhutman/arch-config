#!/bin/bash

# First parameter is the user's name, defaults to "test"
[ -z "$1" ] && DEL_USER="test" || DEL_USER="$1"

# Kill any processes belonging to user
ACTIVE_PROCS="$(ps -u $DEL_USER | tail -n +2 | awk '{ print $1 }')"
[ -n "$ACTIVE_PROCS" ] && echo "$ACTIVE_PROCS" | xargs sudo kill -9 

# Remove user and their home directory
sudo deluser --remove-home "$DEL_USER"
