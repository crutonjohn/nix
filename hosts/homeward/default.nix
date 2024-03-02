{ config, lib, nixpkgs, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-hidpi
    ./hardware-configuration.nix
    ./vm-hook.nix
    ./hardware.nix
    ./loader.nix
    ./networking.nix
    ./virtualization.nix
    ./wayland.nix
    ./hyprland.nix
    ./greeter.nix
  ];

  time.timeZone = "America/New_York";

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      n.flake = inputs.nixpkgs;
      stable.flake = inputs.nixpkgs-stable;
      s.flake = inputs.nixpkgs-stable;
    };
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://cuda-maintainers.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
      ];

      trusted-users = [ "root" "crutonjohn" ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      allowBitmaps = true;
    };
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-extra
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      noto-fonts-cjk
      open-sans
      ubuntu_font_family
      iosevka
      aileron
      fira-code
      fira-code-symbols
      font-awesome_5
      material-icons
      material-symbols
    ];
  };

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
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Flatpak
  services.flatpak.enable = true;

  # Programs
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.wireshark.enable = true;

  programs.fish.enable = true;

  # SSH Server
  services.openssh.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };


  system.stateVersion = "23.11";

}
