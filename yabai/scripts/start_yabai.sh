#!/bin/bash

brew services start yabai

# Detects if Magnet is running
if pgrep -f "Magnet" > /dev/null; then
    kill $(pgrep -f "Magnet")
fi
