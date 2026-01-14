{ inputs, ... }:

{
  imports = [
    ../global
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd

    ./minio
    ./podman
    ./prometheus
    ./hardware-configuration.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    ./nfs.nix
    ./nginx.nix
    ./smb.nix
    ./virtualization.nix
    ./vm-hook.nix
    ./zfs.nix
  ];

  time.timeZone = "America/New_York";

  # SSH Server
  services.openssh.enable = true;

  system.stateVersion = "25.11";

}
