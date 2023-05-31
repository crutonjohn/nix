{ config, lib, pkgs, outputs, ... }: {
  imports = [ 
    ../common/custom-modules/pasystray
  ];
  
  services.pasystray-custom.enable = true;

}