{ config, lib, pkgs, ... }:
{

  services.xserver.enable = false;
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
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

}

