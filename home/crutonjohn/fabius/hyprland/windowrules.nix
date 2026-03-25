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

      ];
    };
  };
}
