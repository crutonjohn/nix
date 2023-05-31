{ config, lib, pkgs, outputs, ... }: {
  imports = [
    ./scripts
    ./pasystray.nix
    ./picom.nix
    ../common/personal.nix
  ];

  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";

  # Blueman
  services.blueman-applet.enable = true;

  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ../apps/i3/ws1.json;
  home.file.".config/i3/ws2.json".source = ../apps/i3/ws2.json;
  home.file.".config/i3/ws3.json".source = ../apps/i3/ws3.json;
  home.file.".config/i3/screen_shot.sh".source = ../apps/i3/screen_shot.sh;
  home.file.".config/i3/lockicon.png".source = ../apps/i3/lockicon.png;
  home.file.".config/polybar/hack" = {
    source = ./polybar/hack;
    recursive = true;
  };
  home.file.".config/polybar/material" = {
    source = ./polybar/material;
    recursive = true;
  };

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

  home.file.".config/wall".source = ./bg;

}
