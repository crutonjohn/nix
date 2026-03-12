{ ... }:
{

  imports = [
  ];


  wayland.windowManager.hyprland = {
    settings = {
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgb(ffc0cb)";
        "col.inactive_border" = "rgba(595959aa)";
      };
    };
  };
}
