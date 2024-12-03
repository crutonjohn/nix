{ config, lib, pkgs, ... }:
{

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "breeze";
  };
  environment = {
    systemPackages = with pkgs; [
      sddm-chili-theme
    ];
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  };

}

