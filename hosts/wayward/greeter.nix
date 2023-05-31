{ config, lib, pkgs, ... }:
{
  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    fish
    bash
    Hyprland
  '';
}

