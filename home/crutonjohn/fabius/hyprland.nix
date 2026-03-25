{ pkgs, inputs, ... }:
{

  imports = [
    ../common/hyprland/binds.nix
    ../common/hyprland/hypridle.nix
    ../common/hyprland/hyprlock.nix
    ../common/hyprland/wofi.nix
    ../common/hyprland/cursor.nix
    ../common/hyprland/dunst.nix
    ./hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
