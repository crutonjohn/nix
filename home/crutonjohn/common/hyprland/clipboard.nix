{ ... }:
{

  imports = [
  ];

  home = {
    packages = with pkgs; [
      cliphist
    ];
  };

  wayland.windowManager.hyprland = {
    exec-once = {
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
    };
    settings = {
      bind = [
        "SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
      ];
    };
  };
}
