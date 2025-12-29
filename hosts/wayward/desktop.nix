{ config, pkgs, inputs, lib, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  #nixGL.packages = inputs.nixgl.packages;
  #nixGL.defaultWrapper = "mesa";
  #nixGL.offloadWrapper = "nixGLIntel";
  #nixGL.installScripts = [ "mesa" ];
  #nixGL.vulkan.enable = true;

  services = { desktopManager.plasma6 = { enable = true; }; };

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
    ];
  };

  #nixpkgs.overlays = [
  #  (final: prev: {
  #    waybar = let
  #      hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  #      waybarPatchFile =
  #        import ./workspace-patch.nix { inherit pkgs hyprctl; };
  #    in prev.waybar.overrideAttrs (oldAttrs: {
  #      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  #      patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
  #      # postPatch = (oldAttrs.postPatch or "") + ''
  #      #   sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
  #      # '';
  #    });
  #  })
  #];

  services.xserver = { xkb.options = "caps:escape"; };

  console.keyMap = "us";

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  security.polkit.enable = true;

}
