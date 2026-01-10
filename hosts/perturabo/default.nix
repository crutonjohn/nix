{ inputs, pkgs, ... }:

{
  imports = [

    # ./minio
    # ./podman
    ./prometheus

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    ./hardware-configuration.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    # ./nfs.nix
    ./nginx.nix
    # ./smb.nix
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
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf17GcWtY5nlZ8gMCHAFDqXaMZ1Tg4j18TCp4B8fdAoMKc5Q0ygVlBz+O8nakIqJRsVMi4tfD3eQjGH28UJOeTGU9F5z2ztlbd/oH/Z39QPK+u03+zsFHxE8El5vtv6PGW7YNcT2S449QbEDs9pLZKmvyTDkwdUyrcbJzQy4OFBFUaGSgCSCPZcRSn0gDWKDeAxS9W84VJeNHEtRSCd3H3KyJdIqSkopUDokxou7H+jGceyEGaNdEI+fw69oYcQB28VAOSgUe8AIcs7Jd7iN6ExlzfWmpdeyeTRmYs0K4kgL3h8JHiJkd3XdlDzFVIKP26oTbEmYd/jVOTuRdsunJp"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK1AE5OJ9NDmob6zeBlH02aBeExtVxMhrBjxo9hB2Pjw"
    ];
  };

  system.stateVersion = "25.11";

}
