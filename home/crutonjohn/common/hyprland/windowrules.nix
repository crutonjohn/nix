{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [

        ### Firefox/Floorp PiP ###
        "float,title:^(Picture-in-Picture)$"
        "size 896 504,title:^(Picture-in-Picture)$"
        "move 4158 46,title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        ##########################

        ### Discord Streaming Popout ###
        "float, initialTitle:^(Discord Popout)$"
        "size 1085 901, initialTitle:^(Discord Popout)$"
        "pin, initialTitle:^(Discord Popout)$"
        ### Discord To Special Workspace ###
        # "workspace special, initialClass:^(discord)$, initialTitle:^(Discord)$"
        ################################

        ### xwaylandvideobridge hider ###
        "opacity 0.0 override, class:^(xwaylandvideobridge)$"
        "noanim, class:^(xwaylandvideobridge)$"
        "noinitialfocus, class:^(xwaylandvideobridge)$"
        "maxsize 1 1, class:^(xwaylandvideobridge)$"
        "noblur, class:^(xwaylandvideobridge)$"
        "nofocus, class:^(xwaylandvideobridge)$"
        #################################

      ];
    };
  };
}
