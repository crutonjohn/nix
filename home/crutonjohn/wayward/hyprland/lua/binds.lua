-----------------------
---- KEYBINDS ---------
-----------------------
local M = "SUPER"

-- Brightness
hl.bind("XF86MonBrightnessUp",
        hl.dsp.exec_cmd("brightnessctl -d intel_backlight s +5%"))
hl.bind("XF86MonBrightnessDown",
        hl.dsp.exec_cmd("brightnessctl -d intel_backlight s 5%-"))

-- Terminal
hl.bind(M .. " + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(M .. " + SHIFT + Return",
        hl.dsp.exec_cmd('alacritty --class="termfloat"'))

-- Session / WM
hl.bind(M .. " + SHIFT + R",
        hl.dsp.exec_cmd("hyprctl reload && pkill -l USR2 waybar"))
hl.bind(M .. " + SHIFT + Escape", hl.dsp.exit())
hl.bind(M .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(M .. " + SHIFT + Space", hl.dsp.window.float({action = "toggle"}))
hl.bind(M .. " + F", hl.dsp.window.fullscreen())
hl.bind(M .. " + Y", hl.dsp.window.pin())
hl.bind(M .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(M .. " + K", hl.dsp.group.toggle())
hl.bind(M .. " + Tab", hl.dsp.window.cycle_next())

-- Gaps toggle
hl.bind(M .. " + G", hl.dsp.exec_cmd(
            'hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"'))
hl.bind(M .. " + SHIFT + G", hl.dsp.exec_cmd(
            'hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"'))

-- Focus movement
hl.bind(M .. " + left", hl.dsp.window.move_focus("l"))
hl.bind(M .. " + right", hl.dsp.window.move_focus("r"))
hl.bind(M .. " + up", hl.dsp.window.move_focus("u"))
hl.bind(M .. " + down", hl.dsp.window.move_focus("d"))

-- Workspaces 1–9 + named
for i = 1, 9 do
    hl.bind(M .. " + " .. i, hl.dsp.workspace.move({tostring(i)}))
    hl.bind(M .. " + CTRL + " .. i, hl.dsp.window.move({tostring(i)}))
    hl.bind(M .. " + SHIFT + " .. i, hl.dsp.window.move(tostring(i)))
end
hl.bind(M .. " + 0", hl.dsp.workspace.go("gaming"))
hl.bind(M .. " + CTRL + 0", hl.dsp.window.move_to_workspace("gaming"))
hl.bind(M .. " + SHIFT + 0", hl.dsp.window.move_to_workspace_silent("gaming"))

-- Named workspaces
hl.bind(M .. " + Q", hl.dsp.workspace.go("QQ"))
hl.bind(M .. " + T", hl.dsp.workspace.go("TG"))
hl.bind(M .. " + M", hl.dsp.workspace.go("Music"))

-- Relative workspaces
hl.bind(M .. " + period", hl.dsp.workspace.go("e+1"))
hl.bind(M .. " + comma", hl.dsp.workspace.go("e-1"))
hl.bind(M .. " + slash", hl.dsp.workspace.go("previous"))

-- Relative move to workspace
hl.bind(M .. " + CTRL + left", hl.dsp.window.move_to_workspace("e-1"))
hl.bind(M .. " + CTRL + right", hl.dsp.window.move_to_workspace("e+1"))

-- Special workspace (scratchpad)
hl.bind(M .. " + minus", hl.dsp.window.move_to_workspace("special"))
hl.bind(M .. " + equal", hl.dsp.workspace.toggle_special())

-- Move windows
hl.bind(M .. " + SHIFT + left", hl.dsp.window.move("l"))
hl.bind(M .. " + SHIFT + right", hl.dsp.window.move("r"))
hl.bind(M .. " + SHIFT + up", hl.dsp.window.move("u"))
hl.bind(M .. " + SHIFT + down", hl.dsp.window.move("d"))

-- Scroll workspaces with mouse wheel
hl.bind(M .. " + mouse_down", hl.dsp.workspace.go("e+1"))
hl.bind(M .. " + mouse_up", hl.dsp.workspace.go("e-1"))

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("mpc -q toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("mpc -q next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("mpc -q prev"))

-- Waybar toggle
hl.bind(M .. " + O", hl.dsp.exec_cmd("pkill -l USR1 waybar"))

-- Resize
hl.bind("CTRL + SHIFT + left", hl.dsp.window.resize({x = -15, y = 0}))
hl.bind("CTRL + SHIFT + right", hl.dsp.window.resize({x = 15, y = 0}))
hl.bind("CTRL + SHIFT + up", hl.dsp.window.resize({x = 0, y = -15}))
hl.bind("CTRL + SHIFT + down", hl.dsp.window.resize({x = 0, y = 15}))
hl.bind("CTRL + SHIFT + h", hl.dsp.window.resize({x = -15, y = 0}))
hl.bind("CTRL + SHIFT + l", hl.dsp.window.resize({x = 15, y = 0}))
hl.bind("CTRL + SHIFT + k", hl.dsp.window.resize({x = 0, y = -15}))
hl.bind("CTRL + SHIFT + j", hl.dsp.window.resize({x = 0, y = 15}))

-- App launcher / clipboard
hl.bind(M .. " + SPACE", hl.dsp.exec_cmd("wofi -S drun --allow-images"))
hl.bind(M .. " + V", hl.dsp
            .exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd(
            "grimblast --notify --cursor copy screen ~/Pictures/$(date '+%Y-%m-%dT%H:%M:%S_no_watermark').png"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast --notify copy area"))

-- Lid switch
hl.bind("switch:off:Lid Switch", hl.dsp
            .exec_cmd('hyprctl keyword monitor "eDP-1, preferred, auto, 1.6"'),
        {locked = true})
hl.bind("switch:on:Lid Switch",
        hl.dsp.exec_cmd('hyprctl keyword monitor "eDP-1, disable"'),
        {locked = true})

-- Mouse window management
hl.bind(M .. " + mouse:272", hl.dsp.window.move_with_mouse(), {mouse = true})
hl.bind(M .. " + mouse:273", hl.dsp.window.resize_with_mouse(), {mouse = true})
