{ pkgs, ...}:
{
  home.packages = [
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

    (pkgs.writeScriptBin "nrbu" ''
    #!/usr/bin/env bash
    cd $HOME/Documents/nixos
    sudo nixos-rebuild switch --upgrade --flake '.#endurance'
    '')

    (pkgs.writeScriptBin "nrb" ''
    #!/usr/bin/env bash
    cd $HOME/Documents/nixos
    sudo nixos-rebuild switch --flake '.#endurance'
    '')

    (pkgs.writeScriptBin "launchrofi" ''
    #!/usr/bin/env bash
    rofi -no-lazy-grab -show combi -combi-modes "run,drun" -modes combi -theme ~/.config/polybar/material/scripts/rofi/launcher.rasi
    '')

  ];
}
