{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        rounding = 5;
        rounding_power = 2;
        dim_inactive = false;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = false;
          new_optimizations = true;
          xray = true;
        };
      };

      animations = {
        enabled = true;
        bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 5, default"
          "fade, 1, 8, default"
          "workspaces, 1, 6, overshot, slidevert"
        ];
      };
    };
  };
}
