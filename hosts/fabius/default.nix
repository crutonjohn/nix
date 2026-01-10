{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ../global
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
    ./flatpak.nix
  ];

  time.timeZone = "America/New_York";

  # SSH Server
  services.openssh.enable = true;

  # Enable Flatpak
  services.flatpak.enable = true;

  system.stateVersion = "25.11";

}
