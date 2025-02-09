{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./desktop.nix
    ./fonts.nix
    ./greeter.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./vm-hook.nix
    ./loader.nix
    ./networking.nix
    ./virtualization.nix
    ./vm-hook.nix
    ./gaming.nix
  ];

  time.timeZone = "America/New_York";

  # SSH Server
  services.openssh.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  system.stateVersion = "24.05";

}
