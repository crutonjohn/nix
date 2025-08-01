{ ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    # used to find UEFI bootable Windows Parts
    #edk2-uefi-shell.enable = true;
    windows = {
      "11" = {
        title = "Windows 11 Shitty OS Edition";
        efiDeviceHandle = "HD2b";
      };
    };
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];

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
