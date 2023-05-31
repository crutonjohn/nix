{ pkgs, ... }: {
  home.packages = [
    # (pkgs.writeScriptBin "launchrofi" ''
    #   #!/usr/bin/env bash
    #   rofi -no-lazy-grab -show combi -combi-modes "run,drun" -modes combi -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi
    # '')
  ];
}
