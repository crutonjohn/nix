{ inputs, pkgs, ... }:

{
  imports = [

    ./minio
    ./podman
    ./prometheus

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
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

  users.users.crutonjohn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    home = "/home/crutonjohn";
    packages = with pkgs; [
      vim
      tree
      lego
      sops
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3IymQJLihK5LZXw1cf4vw3X9iLyQ9qJn/RPHd4ccvTdcFGzJYiE2H62DCpZaYh/VXqAb5RziEGUkAvPncBAvFuvbzSrsGwd5D9TQwGPKIv/IB3cHSS/XhQbIb4A+UJ482LLd1hZE6Ddm6C3BQIXfEPD94+NxPHF670/BrLQkrWgt8Sd4n9lzuwE9mtOeIvcyiE4zhdDrM68tEKS5fSgrKqff7ldpCzLC6drgf3LZzi7xpGyscnNXaUD5t9yB9VyRlaF3y1FkY9GStZQ/izyH9BOfDurqtlX6YhhWd4kFDnRVPWbF3Z6wXatmhlv9IDjemhFFp3Xqh670SFT2YyRf344MhI32WjeE25aSCPZYuOAZL0TAnILlnfrOJjvSR+zpOTnpTCz8z4ReG9CoNHUNEDsdjXxqrki3Z/7sYSYLm/rUlCJREhxWbLHh7a2SOUeIUzRLlIaBUlbdPWYPyuluMe5MgctglO4Nc/IBYJb7baV/8g79tDaS4PMLIilQZ950="
    ];
  };

  system.stateVersion = "25.11";

}
