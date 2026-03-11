{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.play-nix.nixosModules.play
    ../global
    ../common/virtualization
    ../common/wayland
    ../common/audio.nix
    ../common/core.nix
    ../common/fonts.nix
    ../common/gaming.nix
    ../common/greeter.nix
    ../common/hardware.nix
    ../common/ld.nix
    ../common/networking.nix
    ../common/nix-meta.nix
    ../common/vm-hook.nix
    ./hardware-configuration.nix
    # Auto-install Flatpaks
    ./flatpak.nix
    # For kernel version pinning
    ./kernel.nix
    ./vm-hook.nix
  ];

  # Imported Play module
  play = {
    amd.enable = true; # AMD GPU optimization
  };

  # System Level Packages
  environment = {
    systemPackages = with pkgs; [
      rocmPackages.rocgdb
      amdgpu_top
    ];
  };
  services.ceph.client.enable = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  hardware.amdgpu.opencl.enable = true;

  # Bootloader
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
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
  ];

  # Networking
  networking.hostName = "fabius";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [
      53
      51830
    ];
    # allowedUDPPorts = [ 51830 ]; # Clients and peers can use the same port, see listenport
  };
  networking.nat = {
    enable = true;
    externalInterface = "enp8s0";
    #    internalInterfaces = [ "wg0" ];
  };

}
