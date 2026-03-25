{ ... }:
{

  imports = [
  ];

  wayland.windowManager.hyprland = {
    settings = {

      general = {
        layout = "dwindle";
      };

      dwindle = {
        force_split = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_on_top = true;
        special_scale_factor = 0.8;
      };
    };
  };
}
