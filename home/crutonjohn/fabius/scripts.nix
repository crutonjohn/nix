{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ##################
    # Custom Scripts #
    ##################
    (pkgs.writeScriptBin "wofi-powermenu" ''
      #!/usr/bin/env bash

      entries="⇠ Logout\n⏾ Suspend\n⭮ Reboot\n⏻ Shutdown"

      selected=$(echo -e $entries|wofi --width 250 --height 210 --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

      case $selected in
        logout)
          loginctl kill-session $XDG_SESSION_ID;;
        suspend)
          exec systemctl suspend;;
        reboot)
          exec systemctl reboot;;
        shutdown)
          exec systemctl poweroff -i;;
      esac
    '')

  ];

  programs.fish = {
    functions = {
      nrb = "sudo nixos-rebuild switch --flake github:crutonjohn/nix#fabius --option tarball-ttl 0";
      nrbu = "sudo nixos-rebuild switch --upgrade --flake github:crutonjohn/nix#fabius --option tarball-ttl 0";
      nrbl = "sudo nixos-rebuild switch --flake /home/crutonjohn/nix#fabius'";
      nrbl-nord = "sudo nixos-rebuild switch --use-remote-sudo --build-host localhost --target-host nord --flake '/home/crutonjohn/nix#nord'";
      nrbu-nord = "sudo nixos-rebuild switch --use-remote-sudo --build-host localhost --target-host nord --flake 'github:crutonjohn/nix#nord'";
    };
  };

}
