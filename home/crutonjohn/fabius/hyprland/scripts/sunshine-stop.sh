#!/usr/bin/env bash
# sunshine-stop.sh

# Kill steam
sudo setsid steam steam://close/bigpicture

# Disable the fake display
hyprctl keyword monitor "HDMI-A-1,disable"

# Re-enable physical displays
hyprctl keyword monitor "DP-1, 5120x1440@119.99900, 0x0, 1"
hyprctl keyword monitor "DP-2, 3840x2160@239.99, 1280x1440, 1.5"

# Restore normal window rules
hyprctl reload
