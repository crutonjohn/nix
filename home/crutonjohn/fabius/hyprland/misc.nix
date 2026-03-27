{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {
      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        swallow_regex = "";
        focus_on_activate = true;
      };
    };
  };
}
