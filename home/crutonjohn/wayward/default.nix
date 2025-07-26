{ config, lib, pkgs, inputs, outputs, ... }: {

  imports = [
    ../common
    ./wallpapers
    ./programs
    ./cursor.nix
    ./desktop.nix
    ./git.nix
    ./hyprland-variables.nix
    ./hyprland.nix
    ./scripts.nix
    ./waybar.nix
    ./kanshi.nix
    ./wofi.nix
    ./swaylock.nix
  ];

  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";

  home.packages = with pkgs; [
    appimage-run
    at-spi2-atk
    bambu-studio
    bitwarden-desktop
    brightnessctl
    catimg
    catt
    ceph
    colmena
    comma
    discord
    dmenu
    docker
    docker-compose
    font-manager
    galculator
    gettext
    gimp
    gnome-network-displays
    godot_4
    helvum
    hexchat
    hyprpaper
    imagemagick
    inputs.compose2nix.packages.x86_64-linux.default
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    jdk11
    kanshi
    lapce
    libgcc
    libinput
    libnotify
    lychee-slicer
    mqttui
    neofetch
    networkmanager
    networkmanager_dmenu
    nextcloud-client
    nfs-utils
    nil
    nmap
    openscad
    pamixer
    pavucontrol
    pixman
    pog
    powertop
    psmisc
    pulsemixer
    qemu
    remmina
    rpi-imager
    signal-desktop
    sonixd
    soulseekqt
    step-cli
    sway-contrib.grimshot
    swaybg
    tailscale
    termshark
    tlp
    tuxguitar
    unixtools.procps
    virt-manager
    volctl
    waybar
    wdisplays
    wev
    wineWowPackages.waylandFull
    zeal
    zlib
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
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

  };

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = { enable = true; };
  };

}
