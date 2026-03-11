{ pkgs, inputs, ... }:

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
      wl-clipboard
      wlr-randr
      wlrctl
      wayland
      wayland-scanner
      wayland-utils
      egl-wayland
      wayland-protocols
      xwayland
      pkgs.qt6.qtwayland
      pkgs.qt5.qtwayland
      wf-recorder
      imagemagick
      grim
      hyprcursor
    ];
  };

  security.polkit.enable = true;
  security.pam.services.hyprlock = { };

}
