{ pkgs, inputs, ...}:
{

  imports = [
    ./scripts
  ];

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
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

  # Syncthing
  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
    };
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
      rounded-corners-exclude = [
          "class_g='Bar'"
          "class_g='Rofi'"
          "class_g='dwm'"
      ];
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

  home.file.".config/wall".source = ./bg;

}
