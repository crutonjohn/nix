{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    ./hardware-configuration.nix
    ./vm-hook.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    ./virtualization.nix
    ./wayland.nix
  ];

  time.timeZone = "America/New_York";

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "root" "crutonjohn" ];

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

  users.users = {
    crutonjohn = {
      description = "Curtis Ray John";
      shell = pkgs.fish;
      group = "crutonjohn";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      isNormalUser = true;
      home = "/home/crutonjohn";
    };
    root = {
      shell = pkgs.bashInteractive;
    };
  };

  # User
  users.defaultUserShell = pkgs.fish;

  ## allow me to run nixos-rebuild without a password
  security.sudo.extraRules = [{
    users = [ "crutonjohn" ];
    commands = [{
      command = "/run/current-system/sw/bin/nixos-rebuild";
      options = [ "SETENV" "NOPASSWD" ];
    }];
  }];

  # Flatpak
  services.flatpak.enable = true;

  # Programs
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.fish.enable = true;

  # SSH Server
  services.openssh.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  system.stateVersion = "22.11";

}
