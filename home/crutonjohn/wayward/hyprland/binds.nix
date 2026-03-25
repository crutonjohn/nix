{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };

      bindl = [
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, preferred, auto, 1.6\""
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
      ];

    };
  };
}
