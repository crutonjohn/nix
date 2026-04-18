{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        ",XF86MonBrightnessUp,exec,brightnessctl -d intel_backlight s +5%"
        ",XF86MonBrightnessDown,exec,brightnessctl -d intel_backlight s 5%-"
      ];

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
