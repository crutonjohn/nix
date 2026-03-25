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
        "no_blur on, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "no_dim on, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "no_shadow on, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "opaque on, tag:game"
        "no_anim on, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "rounding 0, tag:game"
        "fullscreen on, initialClass:^(cs2|steam_app_.*|gamescope)$"
        "monitor DP-2, tag:game"
        "workspace 1, tag:game"
      ];
    };
  };
}
