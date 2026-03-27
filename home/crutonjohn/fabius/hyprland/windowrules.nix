{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        ### GAMING ###
        # setting up gaming windows
        "tag +game, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "tag +game, initialTitle:^(Arc Raiders)$"
        "noborder, tag:game"
        "noblur on, nodim on, noshadow on, opaque on, noanim on, rounding 0, fullscreen, monitor DP-2, workspace 1, tag:game"
      ];
    };
  };
}
