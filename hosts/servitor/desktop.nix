{ config, pkgs, inputs, lib, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      libinput
      alsa-lib
      alsa-utils
      flac
      linux-firmware
      sshpass
      rocmPackages.rocgdb
      vim
    ];
  };

  console.keyMap = "us";

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  security.polkit.enable = true;

}
