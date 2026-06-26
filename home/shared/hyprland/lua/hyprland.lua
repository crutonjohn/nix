-- Hyprland entry point. Loaded directly by Hyprland (~/.config/hypr/hyprland.lua
-- is a symlink to this file via home-manager mkOutOfStoreSymlink).
--
-- Extends package.path so require() resolves modules from the live source tree
-- in nixos-config (public) and the per-host directory in infra (private). Edits
-- to any .lua file under either tree are picked up by Hyprland's autoreload
-- without a nixos-rebuild.
local HOME = os.getenv("HOME")
local USER = os.getenv("USER")
local function read_hostname()
    local f = io.open("/etc/hostname", "r")
    if not f then return nil end
    local h = f:read("*l")
    f:close()
    return h
end

local COMMON = HOME .. "/Documents/nix/home/" .. USER .. "/common/hyprland/lua"
local DEVICE = HOME .. "/Documents/nix/home/" .. USER .. "/" ..
                   (read_hostname() or "unknown") .. "/hyprland/lua"

local pkgcommon = COMMON .. "/?.lua"
local pkgdevice = DEVICE .. "/?.lua"

-- Also look in ~/.config/hypr so home-manager-written Lua snippets (e.g. the
-- webapps window-rules generator) are require()able by name.
local XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "/.config")

package.path = package.path .. ";" .. XDG .. "/hypr" .. "/?.lua" .. ";" ..
                   COMMON .. "/?.lua" .. ";" .. DEVICE .. "/?.lua"

-- Helper: require a module only if its source file actually exists, so hosts
-- without per-host overrides don't trigger a "module not found" notification.
-- (Hyprland's require seems to log the failure even when wrapped in pcall.)
local function try_require(name)
    if package.searchpath(name, package.path) then require(name) end
end

local function common(name)
    if package.searchpath(name, pkgcommon) then require(name) end
end

local function device(name)
    if package.searchpath(name, pkgdevice) then require(name) end
end

common("init")
device("init")

-- Nix-generated rules (webapps, etc). Optional file dropped by home-manager.
try_require("webapps")

-- Keybinds: load definitions and any per-host extras before registering, so
-- device-keybinds.lua can append into the categories table and have its binds
-- show up in the rofi menu.
-- Basically, delay loading until after device and device keybinds
local b = require("binds")
try_require("devices")
try_require("device-keybinds")
-- b.register()

require("autoexec")
