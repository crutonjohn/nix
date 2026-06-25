{ lib, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
  ];

  boot.kernelParams = [
    "drm.edid_firmware=HDMI-A-1:edid/yourfile video=HDMI-A-1:e"
  ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # CopyFail
  # boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
  #   lib.mkDefault pkgs.linuxPackages_6_18
  # );

  # for pinning kernel version
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linux_latest.override {
      argsOverride = rec {
        src = pkgs.fetchurl {
          url = "mirror://kernel/linux/kernel/v7.x/linux-${version}.tar.xz";
          sha256 = "CUl362LCDj0ZOf6BqSlYofmH8zlEblMvqGljsoBOMtw=";
        };
        version = "7.0.10";
        modDirVersion = "7.0.10";
      };
    }
  );
}
