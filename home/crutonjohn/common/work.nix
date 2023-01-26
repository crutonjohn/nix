{ pkgs, inputs, ... }: {

  imports = [
    ./generic.nix
    ./generic-linux.nix
    ./custom-modules/audio/pasystray.nix
    ./custom-modules/desktop/picom.nix
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
    pasystray
    polybar
    powertop
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
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
    read-edid

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

  ];

  services.pasystray-custom = { enable = true; };

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
        format = ''
          <b>%s</b>
          %b'';
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
