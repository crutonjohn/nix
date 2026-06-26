-----------------------
---- KEYBINDS ---------
-----------------------
local M = "SUPER"

local N = {}

-- Native-Lua action implementations (multi-step / state-holding). Loaded
-- lazily via require so this file still parses when run by menu.lua.
local actions = nil
local function ensure_actions()
    if actions == nil and hl then actions = require("actions") end
    return actions
end

-- Generic Container for Defining Bind functions
local B = {}

-- Generic exec
B.exec = function(c) return {exec = c} end

-- Exec App with uwsm so that it gets a scope in app-graphical.slice
B.exec_app = function(c) return {exec = "uwsm app -- " .. c} end

B.kill = function()
    return {
        fn = function()
            local active = hl.get_active_window()
            -- Firefox on Wayland quits all windows when the compositor sends
            -- WM_DELETE_WINDOW; send Ctrl+Shift+W instead so Firefox closes
            -- only the focused window internally.
            if active and active.class == "firefox" then
                hl.dispatch(hl.dsp.send_shortcut({
                    mods = "ctrl shift",
                    key = "w"
                }))
            else
                hl.dispatch(hl.dsp.window.kill())
            end
        end
    }
end

B.pin =
    function() return {dispatch = function() return hl.dsp.window.pin() end} end
B.focus_dir = function(d)
    return {dispatch = function() return hl.dsp.focus({direction = d}) end}
end
B.swap_dir = function(d)
    return {
        dispatch = function() return hl.dsp.window.swap({direction = d}) end
    }
end
B.move_xy = function(x, y)
    return {
        dispatch = function()
            return hl.dsp.window.move({x = x, y = y, relative = true})
        end
    }
end
B.resize_xy = function(x, y)
    return {
        dispatch = function()
            return hl.dsp.window.resize({x = x, y = y, relative = true})
        end
    }
end
B.focus_ws = function(n)
    -- Switching the workspace alone (hl.dsp.focus({workspace=n})) changes the
    -- view but does NOT move keyboard focus to a window on it (observed on this
    -- single-monitor setup — focus stays on the previous workspace's window).
    -- Focusing a window directly both switches to its workspace AND focuses it,
    -- so target a window on the workspace (prefer a tiled one); only fall back
    -- to a plain view switch when the workspace is empty.
    return {
        fn = function()
            local wins = hl.get_workspace_windows(n) or {}
            local target = nil
            for _, w in ipairs(wins) do
                if not w.floating then
                    target = w
                    break
                end
            end
            if not target and #wins > 0 then target = wins[1] end
            if target then
                hl.dispatch(hl.dsp
                                .focus({window = "address:" .. target.address}))
            else
                hl.dispatch(hl.dsp.focus({workspace = n}))
            end
        end
    }
end
-- Move window to workspace silently (no follow)
B.move_ws_silent = function(n)
    return {
        dispatch = function()
            return hl.dsp.window.move({workspace = n, follow = false})
        end
    }
end
-- Toggle special namespace
B.toggle_special = function(n)
    return {dispatch = function() return hl.dsp.workspace.toggle_special(n) end}
end
-- toggle layout
B.layout = function(m) return
    {dispatch = function() return hl.dsp.layout(m) end} end
-- Click and Drag to move windows
B.drag = function()
    return {dispatch = function() return hl.dsp.window.drag() end}
end
-- Resize window with mouse
B.mresize = function()
    return {dispatch = function() return hl.dsp.window.resize() end}
end
-- Float a window and pin it across workspaces
B.float_and_pin = function()
    return {
        fn = function()
            hl.dispatch(hl.dsp.window.float())
            hl.dispatch(hl.dsp.window.pin())
        end
    }
end

-- Native-Lua helpers from actions.lua (replace the old hypr-* shell scripts).
B.reset_splits = function()
    return {fn = function() ensure_actions().reset_splits() end}
end
B.dwindle_resize = function(d)
    return {fn = function() ensure_actions().dwindle_resize(d) end}
end
B.resize_step = function(d)
    return {fn = function() ensure_actions().resize_step(d) end}
end
B.colresize_all = function(d)
    return {fn = function() ensure_actions().colresize_all(d) end}
end
B.toggle_special_move = function(n)
    return {fn = function() ensure_actions().toggle_special_move(n) end}
end

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
hl.bind(M .. " + left", hl.dsp.focus({ direction = "left"}))
hl.bind(M .. " + right", hl.dsp.focus({ direction = "right"}))
hl.bind(M .. " + up", hl.dsp.focus({ direction = "up"}))
hl.bind(M .. " + down", hl.dsp.focus({ direction = "down"}))

-- Workspaces 0–9 + named
for i = 1, 10 do
    local key = i % 10
    hl.bind(M .. " + " .. key, hl.dsp.focus({ workspace = i}))
    hl.bind(M .. " + SHIFT + " .. key,
            hl.dsp.window.move({workspace = key, follow = false}))
    hl.bind(M .. " + CTRL + " .. key,
            hl.dsp.window.move({workspace = key, follow = true}))
end

-- Relative workspaces
hl.bind(M .. " + period", hl.dsp.focus({ workspace = "e+1"}))
hl.bind(M .. " + comma", hl.dsp.focus({ workspace = "e-1"}))
hl.bind(M .. " + slash", hl.dsp.focus({ workspace = "previous"}))

-- Relative move to workspace
--hl.bind(M .. " + CTRL + left", hl.dsp.window.move({ workspace = "e-1",))
--hl.bind(M .. " + CTRL + right", hl.dsp.window.move("e+1"))

-- Special workspace (scratchpad)
hl.bind(M .. " + minus",
        hl.dsp.window.move({workspace = "special", follow = true}))
hl.bind(M .. " + equal", hl.dsp.workspace.toggle_special())

-- Move windows hl.dsp.window.swap({direction = d})
hl.bind(M .. " + SHIFT + left", hl.dsp.window.move({direction = "left"}))
hl.bind(M .. " + SHIFT + right", hl.dsp.window.move({direction = "right"}))
hl.bind(M .. " + SHIFT + up", hl.dsp.window.move({direction = "up"}))
hl.bind(M .. " + SHIFT + down", hl.dsp.window.move({direction = "down"}))

-- Scroll workspaces with mouse wheel
hl.bind(M .. " + mouse_down", hl.dsp.focus({workspace = "e-1"}))
hl.bind(M .. " + mouse_up", hl.dsp.focus({workspace = "e+1"}))

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

-- Wofi app launcher / clipboard
hl.bind(M .. " + SPACE", hl.dsp.exec_cmd("wofi -S drun --allow-images"))
hl.bind(M .. " + V", hl.dsp
            .exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd(
            "grimblast --notify --cursor copy screen ~/Pictures/$(date '+%Y-%m-%dT%H:%M:%S_no_watermark').png"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grimblast --notify copy area"))

-- Mouse window management
hl.bind(M .. " + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), {mouse = true})

-- N.binds = {
--     {
--         keys = "SUPER + SHIFT + h",
--         desc = "Swap window left",
--         action = B.swap_dir("l")
--     }, {
--         keys = "SUPER + SHIFT + l",
--         desc = "Swap window right",
--         action = B.swap_dir("r")
--     },
--     {
--         keys = "SUPER + SHIFT + k",
--         desc = "Swap window up",
--         action = B.swap_dir("u")
--     }, {
--         keys = "SUPER + SHIFT + j",
--         desc = "Swap window down",
--         action = B.swap_dir("d")
--     }
-- }

-- -- Re-export the action helpers so device-keybinds.lua can use them
-- N.B = B

-- return N
