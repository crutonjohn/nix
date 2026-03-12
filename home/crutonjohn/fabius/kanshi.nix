{ ... }:
{
  services.kanshi = {
    enable = true;
  };

  wayland.windowManager.hyprland = {
    settings = {
      exec = [ "kanshictl reload" ];
    };
  };

  home.file = {
    ".config/kanshi/config".text = ''
      output "Samsung Electric Company LC49G95T H1AK500000" {
        mode 5120x1440@119.99900
        position 0,0
        scale 1
        alias $G9_1
      }

      output "LG Electronics LG ULTRAGEAR 408NTEPA4044" {
        mode 3840x2160@143.99899
        position 1280,1440
        scale 1.5000000000000004
        alias $LG_1
      }


      profile HOME_1 {
        output $G9_1 enable
        output $LG_1 enable
      }
    '';
  };

}
