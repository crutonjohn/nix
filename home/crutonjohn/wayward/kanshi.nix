{ ... }:
{
  services.kanshi = {
    enable = true;
    settings = [
      {
        output.criteria = "eDP-1";
        output.scale = 1.6;
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
          }
        ];
      }
      {
        profile.name = "home_office";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Samsung Electric Company LC49G95T H1AK500000";
            position = "0,0";
            mode = "5120x1440@59.98Hz";
          }
        ];
      }
    ];

  #home.file = {
  #  ".config/kanshi/config".text = ''
  #    output "Samsung Electric Company LC49G95T H1AK500000" {
  #      mode 5120x1440@119.99900
  #      position 0,0
  #      scale 1.333337
  #      alias $G9_1
  #    }

  #    output "BOE 0x095F Unknown" {
  #      mode 2256x1504@59.99900
  #      position 0,0
  #      scale 1.566667
  #      alias $INTERNAL
  #    }

  #    profile docked_1 {
  #      output $INTERNAL disable
  #      output $G9_1 enable
  #    }
  #    profile mobile_1 {
  #      output $INTERNAL enable
  #    }
  #  '';
  #};

}
