#!/bin/bash

brew services stop yabai

# Detects if Magnet is running
if ! pgrep -f "Magnet" > /dev/null 2>&1; then
    open -a "/Applications/Magnet.app"
fi
