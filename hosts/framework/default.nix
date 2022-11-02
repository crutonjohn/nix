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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # GRUB/Plymouth
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_5_19.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
            sha256 = "Ts24tZxvbyWNicvyLu3iEOClXAnbiEmI/nBu/i/o8Ug=";
      };
      version = "5.19.13";
      modDirVersion = "5.19.13";
      };
  });

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
  services.xserver.windowManager.i3.enable = true;
    # TODO: migrate to i3-gaps
    # package = "pkgs.i3-gaps";
    # TODO: migrate to inline i3 config (maybe)
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
      Xcursor.theme: Adwaita
      Xcursor.size: 32
      Xft.dpi: 144
      Xft.autohint: 0
      Xft.lcdfilter:  lcddefault
      Xft.hintstyle:  hintfull
      Xft.hinting: 1
      Xft.antialias: 1
      Xft.rgba: rgb
    ''}
  '';
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  services.xserver.libinput.touchpad.naturalScrolling = true;
  services.xserver.libinput.touchpad.tapping = false;
  services.xserver.libinput.touchpad.clickMethod = "clickfinger";

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

  #Power stuff
  powerManagement.powertop.enable = true;
  services.logind ={
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
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

  # Sound Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Blueman
  services.blueman.enable = true;

  # Podman
  virtualisation.podman.enable = true;

  # Usbmuxd
  services.usbmuxd.enable = true;

  # Java
  programs.java.enable = true;

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

  # SSH Server
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
