#!/usr/bin/env bash

# workspace 1
i3-msg "workspace admin; append_layout ~/.config/i3/ws1.json"

(alacritty &)

i3-msg "workspace code; append_layout ~/.config/i3/ws2.json"

(vscodium > /dev/null 2>&1 &)
(firefox > /dev/null 2>&1 &)

i3-msg "workspace irc; append_layout ~/.config/i3/ws3.json"

(discord > /dev/null 2>&1 &)