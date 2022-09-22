{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./services.nix
      ./pipewire.nix
      #./hyprland.nix
      #./firefox.nix
    ];

  # GRUB/Plymouth
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.useOSProber = true;
  boot.plymouth = let pack = 1; theme = "connect"; in { enable = true; themePackages = [ (pkgs.callPackage ./packages/plymouth-theme.nix { inherit pack theme; }) ]; };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Overlay Packages
  # nixpkgs.overlays = [ (import ./packages) ];

  # Networking
  networking.hostName = "endurance";
  networking.networkmanager.enable = true;
  boot.kernelModules = [ "iwlwifi" ];
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  networking.wireless.enable = false; 

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11/GNOME
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

  #hardware.opengl.extraPackages = [
  #intel-compute-runtime
  #]; 

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
    ];
  };


  # Configure keymap in X11
  # services.xserver.xkbOptions = {
  #   "caps:escape" # map caps to escape.
  # };

  # User
  users.defaultUserShell = pkgs.zsh;
  users.users.crutonjohn = {
    isNormalUser = true;
    home = "/home/crutonjohn";
    description = "Curtis Ray John";
    extraGroups = [ "wheel" "networkmanager" ];
  };


  # SSID
  # programs.mtr.enable = true;
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
