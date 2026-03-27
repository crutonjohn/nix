{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      gestures = {
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };
    };
  };
}
