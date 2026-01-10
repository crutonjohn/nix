{ ... }:
{
  services.kanshi = {
    enable = true;
  };

  home.file = {
    ".config/kanshi/config".text = ''
      output "Samsung Electric Company LC49G95T H1AK500000" {
        mode 5120x1440@239.76
        position 0,0
        scale 1
        alias $G9_1
      }

      profile HOME_1 {
        output $G9_1 enable
      }
    '';
  };

}
