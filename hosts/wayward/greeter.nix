{ config, lib, pkgs, ... }:
{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-chili-theme";
  };
  environment = {
    systemPackages = with pkgs; [
      sddm-chili-theme
    ];
  };
}

