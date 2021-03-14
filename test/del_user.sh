#!/bin/bash

# Kill any processes belonging to user
ACTIVE_PROCS="$(ps -u test | tail -n +2 | awk '{ print $1 }')"
[ -n "$ACTIVE_PROCS" ] && echo "$ACTIVE_PROCS" | xargs sudo kill -9 

# Remove user and their home directory
sudo deluser --remove-home test
