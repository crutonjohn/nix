#!/usr/bin/env bash
# sunshine-start.sh
W="$SUNSHINE_CLIENT_WIDTH"
H="$SUNSHINE_CLIENT_HEIGHT"
FPS="$SUNSHINE_CLIENT_FPS"

# Disable physical outputs
hyprctl keyword monitor "DP-1,disable"
hyprctl keyword monitor "DP-2,disable"

# Enable and configure the fake EDID display at client resolution
hyprctl keyword monitor "HDMI-A-1,${W}x${H}@${FPS},0x0,1"

# Reload window rules from streaming-mode config
hyprctl keyword source ~/.config/hypr/window-rules-streaming.lua

# Launch Steam Big Picture on the fake display
DISPLAY=:0 sudo -u crutonjohn setsid steam steam://open/bigpicture &
