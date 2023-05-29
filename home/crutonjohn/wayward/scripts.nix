{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ##################
    # Custom Scripts #
    ##################
    (pkgs.writeScriptBin "glsteam" ''
      #!/usr/bin/env bash
      nix run github:guibou/nixGL#nixGLIntel -- steam > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "nrbu" ''
      #!/usr/bin/env bash
      cd $HOME/Documents/nixos
      sudo nixos-rebuild switch --upgrade --flake '.#wayward'
    '')

    (pkgs.writeScriptBin "nrb" ''
      #!/usr/bin/env bash
      cd $HOME/Documents/nixos
      sudo nixos-rebuild switch --flake '.#wayward'
    '')

    (pkgs.writeScriptBin "launchpolybar" ''
      #!/usr/bin/env bash
      POLYBAR_DIR=$HOME/.config/polybar
      $POLYBAR_DIR/material/launch.sh
    '')

    (pkgs.writeScriptBin "launchrofi" ''
      #!/usr/bin/env bash
      rofi -no-lazy-grab -show combi -combi-modes "run,drun" -modes combi -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi
    '')

  ];
}