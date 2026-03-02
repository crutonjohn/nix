{ ... }:
{
  services.kanshi = {
    enable = true;
    # settings = [
    #   {
    #     output.criteria = "eDP-1";
    #     output.scale = 1.6;
    #   }
    #   {
    #     profile.name = "home_office";
    #     profile.outputs = [
    #       {
    #         criteria = "Samsung Electric Company LC49G95T H1AK500000";
    #         position = "0,0";
    #         mode = "5120x1440@59.98Hz";
    #       }
    #     ];
    #   }
    # ];
  };

  home.file = {
    ".config/kanshi/config".text = ''
      output "Samsung Electric Company Odyssey G95C HNTX401810" {
        mode 5120x1440@119.97
        position 2160,1260
        scale 1
        alias $G9_1
      }

      output "LG Electronics LG ULTRAGEAR 404NTTQD1705" {
        mode 3840x2160@143.999
        position 0,0
        scale 1
        alias $LG_1
        transform 90
      }

      profile HOME_1 {
        output $G9_1 enable
        output $LG_1 enable
      }
    '';
  };

}
