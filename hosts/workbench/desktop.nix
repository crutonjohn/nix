{ config, pkgs, inputs, lib, ... }:

{

  # programs.hyprland.enable = true;
  # services.desktopManager.plasma6 = {
  #   enable = true;
  # };

  environment = {
    systemPackages = with pkgs; [
      inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      libnotify
      libinput
      wl-clipboard
      wlr-randr
      wlrctl
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      # pkgs.plasma-wayland-protocols
      pkgs.xorg.xeyes
      glfw
      xwayland
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      libsForQt5.kdeconnect-kde
      nemo
      networkmanagerapplet
      wev
      wf-recorder
      alsa-lib
      alsa-utils
      flac
      pulsemixer
      linux-firmware
      sshpass
      lxappearance
      imagemagick
      grim
      toybox
      rocmPackages.rocgdb
      wireshark
      hyprcursor
      xsettingsd
      xorg.xrdb
    ];
  };

  services.xserver = { xkb.options = "caps:escape"; };

  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  security.polkit.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps: use Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox: use Wayland
    QT_QPA_PLATFORM = "wayland"; # Qt: use Wayland
    SDL_VIDEODRIVER = "wayland"; # SDL: use Wayland
    _JAVA_AWT_WM_NONREPARENTING = "1"; # Java: better Wayland compatibility
  };

}
