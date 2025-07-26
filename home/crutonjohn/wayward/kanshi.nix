{ home, ... }: {
  services.kanshi = {
    enable = true;
  };

  home.file = {
    ".config/kanshi/config".text = ''
      output "Samsung" {
        mode 5120x1440@119.99900
        position 0,0
        scale 2
        alias $G9_1
      }

      output "BOE 0x095F Unknown" {
        mode 2256x1504@59.99900
        position 0,0
        scale 1.566667
        alias $INTERNAL
      }

      profile docked_1 {
        output $INTERNAL disable
        output $G9_1 enable
      }
      profile mobile_1 {
        output $INTERNAL enable
      }
    '';
  };

}
