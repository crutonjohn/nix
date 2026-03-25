{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 1;
        float_switch_override_focus = 2;
        numlock_by_default = true;
        sensitivity = 0.0;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = 1;
          tap-to-click = false;
        };
      };
    };
  };
}
