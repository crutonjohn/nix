{ config, lib, nixpkgs, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./vm-hook.nix
      ../../packages/cachix/cachix.nix
    ];
  
  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  # GRUB/Plymouth
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Networking
  networking.hostName = "endurance";
  networking.networkmanager.enable = true;
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  networking.wireless.enable = false;

  # Time Zone
  time.timeZone = "America/New_York";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable X11/WM
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Intel GPU BS
  services.xserver.videoDrivers = [ "modesetting" ];
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" ];
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Fonts
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      open-sans
      ubuntu_font_family
      iosevka
      aileron
    ];
  };

  # User
  users.defaultUserShell = pkgs.zsh;
  users.users.crutonjohn = {
    isNormalUser = true;
    home = "/home/crutonjohn";
    description = "Curtis Ray John";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Blueman
  services.blueman.enable = true;

  # Podman
  virtualisation.podman.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;

  # Java
  programs.java.enable = true;

  # Starship
  programs.starship.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;
  
  # KVM
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # Programs
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
