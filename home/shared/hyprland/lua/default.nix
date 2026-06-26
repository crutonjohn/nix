{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    # ./scripts.nix
  ];

  # LSP stubs for Hyprland's Lua API at a stable user path. The hyprland
  # package's share/hypr/stubs dir changes hash on each upgrade, so we link
  # it into ~/.local/share/hypr/stubs and reference *that* from .luarc.json.
  # Updates automatically on rebuild.
  home.file.".local/share/hypr/stubs".source = "${
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
  }/share/hypr/stubs";

  # Hyprland user config is driven by the symlinked Lua tree below
  # (lua/hyprland.lua and friends). The home-manager Hyprland module is left
  # disabled here so it doesn't write the legacy hyprland.conf — Hyprland 0.55+
  # reads hyprland.lua natively. The system-level NixOS Hyprland module still
  # handles the session/UWSM/portal bits.
  wayland.windowManager.hyprland.enable = false;
  wayland.windowManager.hyprland.systemd.enable = false;

  # Live-edit symlink: edits to lua/*.lua under
  # ~/Documents/nix/home/<username>/common/hyprland/lua/hyprland.lua (and the
  # per-host overrides under ~/Documents/nix/home/<username>/<host>/hyprland/lua/)
  # take effect immediately via Hyprland's autoreload.
  # No nixos-rebuild needed for keybinds or rules.
  xdg.configFile."hypr/hyprland.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/nix/home/shared/hyprland/lua/hyprland.lua";

  xdg.configFile."hypr/autoexec.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/nix/home/shared/hyprland/lua/autoexec.lua";
  # UWSM env injection — sources home-manager's session vars (including
  # home.sessionPath additions like ~/.local/bin) into the Hyprland session
  # via UWSM. Without this, Hyprland-spawned processes can't find
  # home.file-installed scripts in ~/.local/bin (rofi menus, pypr-toggle-smart,
  # etc.). Per https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/#nixos-uwsm.
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
