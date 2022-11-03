{ config, pkgs, nixpkgs, lib, ... }:
let
  nixFlakes = (pkgs.writeScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '');
in {
  imports = [
    ../generic.nix
    ../generic-linux.nix
  ];

  services.picom.enable = true;

  home.packages = with pkgs; [
    _1password
    arandr
    autorandr
    blink1-tool
    byzanz
    dmenu
    dunst
    esbuild
    espeak
    flameshot
    gnome-icon-theme
    libnotify
    nixFlakes
    nyxt
    pavucontrol
    picom
    sass
    xrectsel
    zlib
  ];

  home.file.".xsessionrc".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$PATH
    xset r rate 200 50
    '';
}

