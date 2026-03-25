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
        "no_blur on, tag:game"
        "no_dim on, tag:game"
        "no_shadow on, tag:game"
        "opaque on, tag:game"
        "no_anim on, tag:game"
        "rounding 0, tag:game"
        "fullscreen on, tag:game"
        "monitor DP-2, tag:game"
        "workspace 1, tag:game"
      ];
    };
  };
}
