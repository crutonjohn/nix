{
  pkgs,
  ...
}:

{

  home = {
    packages = with pkgs; [
      networkmanager
      networkmanager_dmenu
    ];
  };

  wayland.windowManager.hyprland = {
    settings = {

      exec-once = [
        "nm-applet --indicator &"
      ];

    };
  };
}
