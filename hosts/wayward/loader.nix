{ lib, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
  ];

  # CopyFail
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
    lib.mkDefault pkgs.linuxPackages_6_18
  );

  # for pinning kernel version
  #  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_19.override {
  #    argsOverride = rec {
  #      src = pkgs.fetchurl {
  #            url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
  #            sha256 = "Ts24tZxvbyWNicvyLu3iEOClXAnbiEmI/nBu/i/o8Ug=";
  #      };
  #      version = "5.19.13";
  #      modDirVersion = "5.19.13";
  #      };
  #  });
}
