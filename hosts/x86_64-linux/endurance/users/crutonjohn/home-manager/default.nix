{ config, lib, pkgs, flakePkgs, ... }:

{
  imports = [
    ./git.nix
    ./scripts.nix
    ./custom-modules/desktop/picom.nix
    ./custom-modules/audio/pasystray.nix
  ];

  home.packages = with pkgs; [
    signal-desktop
    steam
    discord
    cura
    docker-compose
    i3status-rust
    networkmanager_dmenu
    docker
    i3
    comma
    feh
    nfs-utils
    nerdfonts
    networkmanager
    rofi
    polybar
    powertop
    pavucontrol
    pulsemixer
    volctl
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
    arandr
    picom
    scrot
    imagemagick
    xorg.xev
    libnotify
    sonixd
    neofetch
    catimg
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

  services.pasystray-custom.enable = true;

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

  services.picom-custom = {
    enable = true;
    backend = "glx";
    fade = true;
    shadow = false;
    inactiveOpacity = 0.9;
    vSync = true;
    fadeDelta = 10;
    settings = {
      animations = true;
      animation-for-transient-window = "fly-in";
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "zoom";
      animation-dampening = 25;
      # animation-window-mass = 0.5
      animation-delta = 10;
      animation-clamping = false;
      corner-radius = 0;
      round-borders = 0;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      use-damage = false;
      blur = {
        method = "dual_kawase";
        strength = 3;
      };
      rounded-corners-exclude =
        [ "class_g='Bar'" "class_g='Rofi'" "class_g='dwm'" ];
      blur-background-exclude = [
        "name *= 'slop'"
        "name = 'cpt_frame_window'"
        "name = 'as_toolbar'"
        "name = 'zoom_linux_float_video_window'"
        "name = 'AnnoInputLinux'"
        "name = 'firefox'"
      ];
      opacity-rule = [
        "50:class_g = 'xest-exe'"
        "100:class_g = 'Alacritty'"
        "90:class_g = 'st-256color'"
        "100:name *?= 'vlc'"
        "100:name *?= 'polybar'"
        "100:name *?= 'firefox'"
      ];
    };
  };

  #Desktop Experience
  home.file.".config/i3" = {
    source = ./i3;
    recursive = true;
  };
  home.file.".config/polybar" = {
    source = ./polybar;
    recursive = true;
  };
  home.file.".config/wall".source = ./bg;

}
