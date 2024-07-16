{ config, lib, pkgs, inputs, outputs, ... }: {
  imports = [
    ../common/personal.nix
    ./hyprland.nix
    ./git.nix
    ./scripts.nix
    ./fish.nix
  ];

  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";

  home.packages = with pkgs; [
    signal-desktop
    steam
    discord
    docker-compose
    networkmanager_dmenu
    docker
    comma
    nfs-utils
    nerdfonts
    networkmanager
    powertop
    pavucontrol
    pulsemixer
    volctl
    zeal
    psmisc
    zlib
    dmenu
    imagemagick
    libnotify
    libinput
    sonixd
    neofetch
    catimg
    tailscale
    swaybg
    waybar
    wdisplays
    hyprpaper
    sway-contrib.grimshot
    wev
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    catt
    hexchat
    colmena
    vesktop
    tuxguitar
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

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

  #Desktop Experience

  home.file.".config/wall.jpg".source = ./bg;

}
