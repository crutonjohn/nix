{ config, lib, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "sddm-chili-theme";

    environment = {
    systemPackages = with pkgs; [
      sddm-chili-theme
    ];
  };
}

