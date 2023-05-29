{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeScriptBin "webex" ''
      #!/usr/bin/env bash
      pkill CiscoCollabHost
      /opt/Webex/bin/CiscoCollabHost
    '')

    (pkgs.writeScriptBin "slk" ''
      #!/usr/bin/env bash
      /usr/bin/slack > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "1p" ''
      #!/usr/bin/env bash
      /home/bjohn/.nix-profile/bin/1password > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "eaa" ''
      #!/usr/bin/env bash
      /opt/wapp/bin/EAAClient > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "nrb" ''
    #!/usr/bin/env bash
    cd $HOME/Documents/nixos
    home-manager switch --flake '.#bjohn@res-lpw733u9'
    '')

    (pkgs.writeScriptBin "i3loadlayout" ''
      #!/usr/bin/env bash
      # workspace 1
      i3-msg "workspace admin; append_layout ~/.config/i3/ws1.json"
      (alacritty &)
      i3-msg "workspace code; append_layout ~/.config/i3/ws2.json"
      (vscodium > /dev/null 2>&1 &)
      (firefox > /dev/null 2>&1 &)
      i3-msg "workspace irc; append_layout ~/.config/i3/ws3.json"
      (discord > /dev/null 2>&1 &)
    '')

    (pkgs.writeScriptBin "i3lockscreen" ''
      #!/usr/bin/env bash
      icon="$HOME/.config/i3/lockicon.png"
      tmpbg='/tmp/screen.png'
      (( $# )) && { icon=$1; }
      scrot "$tmpbg"
      convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
      convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
      i3lock -i "$tmpbg"
      rm -f "$tmpbg"
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
