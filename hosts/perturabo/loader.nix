{ lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
  ];

  # CopyFail
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
    lib.mkDefault pkgs.linuxPackages_6_18
  );
  boot.zfs.package = pkgs.linuxPackages_6_18.zfs_2_4;

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
