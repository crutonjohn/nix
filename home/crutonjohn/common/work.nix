{ pkgs, inputs, ...}:
{

  imports = [
    ./generic.nix
    ./generic-linux.nix
    ./git.nix
  ];

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    _1password
    _1password-gui
    blueman
    bundix
    i3status-rust
    networkmanager_dmenu
    comma
    feh
    rofi
    polybar
    powertop
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
    picom
    scrot
    imagemagick
    pywal
    arandr
    calc
    siji
    syncthing
    syncthing-tray
    material-icons
    nerdfonts
    glibc
    pulseaudio
    gdk-pixbuf
    pasystray
    read-edid

    (pkgs.writeScriptBin "i3loadlayout" ''
    #!/usr/bin/env bash
    # workspace 1
    i3-msg "workspace 1; append_layout ~/.config/i3/ws1.json"
    (nix run github:guibou/nixGL#nixGLIntel -- alacritty)
    i3-msg "workspace 2; append_layout ~/.config/i3/ws2.json"
    (vscodium > /dev/null 2>&1 &)
    i3-msg "workspace 3; append_layout ~/.config/i3/ws3.json"
    (firefox > /dev/null 2>&1 &)
    i3-msg "workspace 4; append_layout ~/.config/i3/ws4.json"
    (slk)
    i3-msg "workspace 5;
    (webex && eaa)
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
    $POLYBAR_DIR/hack/launch.sh
    '')

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
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        width = 300;
        height = 100;
        offset = "5x30";
        follow = "keyboard";
        transparency = 10;
        frame_color = "#6f398f";
        font = "Noto Sans 9";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 1;
        line_height = 4;
        format = "<b>%s</b>\n%b";
        show_age_threshold = 30;
        separator_height = 2;
        separator_color = "frame";
        markup = "full";
        ignore_newline = "no";
        word_wrap = "yes";
        alignment = "right";
        origin = "bottom-right";
        gap_size = 1;
        stack_duplicates = true;
        corner_radius = 0;
      };
      urgency_low = {
        background = "#282C34";
        foreground = "#ABB2BF";
        timeout = 10;
      };
      urgency_normal = {
        background = "#282C34";
        foreground = "#ABB2BF";
        timeout = 10;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        frame_color = "#FF0000";
        timeout = 0;
      };
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

}
