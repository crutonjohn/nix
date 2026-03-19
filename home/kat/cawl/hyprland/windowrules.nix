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
        "workspace special, initialClass:^(discord)$, initialTitle:^(Discord)$"
        ################################

        ## steam windows ##
        "float, initialClass:steam, class:steam"
        "pseudo, initialClass:steam, class:steam"
        "float, title:Friends List, class:steam"
        "size 504 896, title:Friends List, class:steam"
        "pseudo, title:Friends List, class:steam"
        "float, title:^.*(Chat).*$, class:steam"
        "size 504 896, title:^.*(Chat).*$, class:steam"
        "pseudo, title:^.*(Chat).*$, class:steam"
        ##############

        ### GAMING ###
        # setting up gaming windows
        "tag +game, initialClass:^(cs2|steam_app_.*)$"
        "noborder, tag:game"
        #"pseudo, tag:game"
        "float, tag:game"
        "roundingpower 0, tag:game"
        "size 2560 1440, tag:game"
        "noblur, tag:game"
        "content game, tag:game"

        ### Testing Abyssus ###
        "float, initialTitle:^(Abyssus)$"
        "size 2560 1440, initialTitle:^(Abyssus)$"

        ## setting up static workspace ##
        "workspace gaming, class:^(steam)$"
        "workspace gaming, tag:game"
        #"move 0 0, initialTitle:Steam, workspace gaming"
        #"move 1280 0, tag:game, workspace gaming"
        #"size 2560 1440, tag:game, workspace gaming"
        #"move 3840 0, class:^(floorp)$, workspace gaming"
        #"size 1280 1440, class:^(floorp)$, workspace gaming"
        # "setprop keepaspectratio 1, tag:game"
        # "setprop size 2560 1440, tag:game"
        # "setprop norounding 1, tag:game"

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
