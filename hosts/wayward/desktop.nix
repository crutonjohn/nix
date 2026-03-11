{
  config,
  pkgs,
  inputs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

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
      pkgs.xorg.xeyes
      glfw
      xwayland
      pkgs.qt6.qtwayland
      pkgs.qt5.qtwayland
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
      androidenv.androidPkgs.platform-tools
    ];
  };

  services.xserver = {
    xkb.options = "caps:escape";
  };

  console.keyMap = "us";

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  security.polkit.enable = true;

}
