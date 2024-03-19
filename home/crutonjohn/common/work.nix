{ pkgs, inputs, ... }:

{
  imports = [
    ./generic.nix
    ./generic-linux.nix
    ./git.nix
    ./scripts
  ];

  programs.git = {
    enable = true;
    userName = "Buck John";
    includes = [
      {
        path = "~/.config/git/gitconfig-work";
        condition = "gitdir:~/Documents/Projects/";
      }
      {
        path = "~/.config/git/gitconfig-personal";
        condition = "gitdir:~/Documents/nix/";
      }
    ];
  };


  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    _1password
    _1password-gui
    blueman
    i3status-rust
    networkmanager_dmenu
    comma
    cfssl
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
    pulseaudio
    gdk-pixbuf
    read-edid
    mkcert
    slack
    vault
    linode-cli

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
