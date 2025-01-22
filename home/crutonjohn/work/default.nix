{ config, lib, pkgs, outputs, ... }: {
  imports = [
    ./autorandr.nix
    ./dunst.nix
    ./fish.nix
    ./git.nix
    ./scripts
    ./pasystray.nix
    ./picom.nix
    ./pkgs
  ];

  home.username = "bjohn";
  home.homeDirectory = "/home/bjohn";
  home.stateVersion = "24.11";

  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

  # Locale Fixes
  home.file.".xsessionrc".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$PATH:$HOME/.krew/bin
    xset r rate 200 50
    export LOCALES_ARCHIVE=/usr/lib/locale/locale-archive
    export LOCALE_ARCHIVE_2_27=/usr/lib/locale/locale-archive
  '';

  # Scaling Fixes
  home.file.".Xresources".text = ''
    Xcursor.theme: Adwaita
    Xcursor.size: 96
    Xft.autohint: 0
    Xft.lcdfilter:  lcddefault
    Xft.hintstyle:  hintfull
    Xft.hinting: 1
    Xft.antialias: 1
    Xft.rgba: rgb
  '';
  home.file.".xinitrc".text = ''
    xrdb -merge ~/.Xresources
    xset +fp ~/.fonts/misc/
    picom -b
  '';

  # (more) Locale Fixes
  home.sessionVariables.LOCALES_ARCHIVE =
    "${pkgs.glibcLocales}/lib/locale/locale-archive";
  home.sessionVariables.LOCALE_ARCHIVE_2_27 =
    "${pkgs.glibcLocales}/lib/locale/locale-archive";

  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ./i3/layout/ws1.json;
  home.file.".config/i3/ws2.json".source = ./i3/layout/ws2.json;
  home.file.".config/i3/ws3.json".source = ./i3/layout/ws3.json;
  home.file.".config/i3/ws4.json".source = ./i3/layout/ws4.json;
  home.file.".config/polybar/hack" = {
    source = ./polybar/hack;
    recursive = true;
  };
  home.file.".config/polybar/material" = {
    source = ./polybar/material;
    recursive = true;
  };

  # ssh to debian fix
  home.sessionVariables.TERM =
    "xterm-256color";

  home.file.".config/wall".source = ../common/bg;
}
