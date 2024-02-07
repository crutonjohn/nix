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
    ./x11.nix
  ];

  time.timeZone = "America/New_York";

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "root" "crutonjohn" ];

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # Fonts
  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
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
  users.defaultUserShell = pkgs.fish;
  users.users = {
    crutonjohn = {
      description = "Curtis Ray John";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" "docker" "dialout" "wireshark" "libvirtd" ];
      isNormalUser = true;
      home = "/home/crutonjohn";
    };
    root = {
      shell = pkgs.bashInteractive;
    };
  };

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

  system.stateVersion = "22.11";

}
