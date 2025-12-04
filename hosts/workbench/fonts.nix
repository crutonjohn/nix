{ config, lib, nixpkgs, pkgs, inputs, ... }:

{

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      allowBitmaps = true;
    };
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      open-sans
      ubuntu_font_family
      iosevka
      aileron
      fira-code
      fira-code-symbols
      font-awesome_5
      material-icons
      material-symbols
      pciutils
    ];
  };

}
