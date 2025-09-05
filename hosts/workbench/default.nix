{ inputs, ... }:

{
  imports = [

    ./minio
    ./podman
    ./prometheus

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    # ./desktop.nix
    ./fonts.nix
    # ./greeter.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    ./nfs.nix
    ./nginx.nix
    # ./obs.nix
    ./smb.nix
    ./virtualization.nix
    ./vm-hook.nix
    ./zfs.nix
  ];

  time.timeZone = "America/New_York";

  # SSH Server
  services.openssh.enable = true;

  system.stateVersion = "24.05";

}
