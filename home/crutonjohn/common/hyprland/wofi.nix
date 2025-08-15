{
  programs.wofi = {
    enable = true;
    settings = {
      location = "bottom-right";
      allow_markup = true;
      width = 250;
    };
    style = ''
      * {
        font-family: 0xProto Nerd Font Mono;
      }
      window {
        background-color: #7c818c;
      }
    '';
  };

}
