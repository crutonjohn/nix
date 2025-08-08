{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    ./desktop.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    ./virtualization.nix
    ./vm-hook.nix
    ./local-ai.nix
  ];

  time.timeZone = "America/New_York";

  # SSH Server
  services.openssh.enable = true;

  system.stateVersion = "25.05";

}
