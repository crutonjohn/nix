{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    rofi
    rofi-power-menu
    rofi-systemd
  ];

}
