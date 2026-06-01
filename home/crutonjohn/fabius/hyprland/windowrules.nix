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
        ## Steam Big Picture /w Sunshine
        "tag +sunshine, initialTitle:^(Steam\ Big\ Picture\ Mode)"
        "noborder, tag:sunshine"
        "noblur on, nodim on, noshadow on, opaque on, noanim on, rounding 0, fullscreen, monitor HEADLESS-2, workspace 1, tag:sunshine"
      ];
    };
  };
}
