{ config, pkgs, inputs, lib, ... }:

{

  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
          # postPatch = (oldAttrs.postPatch or "") + ''
          #   sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
          # '';
        });
    })
  ];

  environment = {
    systemPackages = with pkgs; [
      inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
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
      glfw-wayland
      xwayland
      pkgs.qt6.qtwayland
      pkgs.qt5.qtwayland
      cinnamon.nemo
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
    ];
  };

  services.xserver = {
    xkb.options = "caps:escape";
  };

  console.useXkbConfig = true;

  services = {
    dbus.packages = [ pkgs.gcr ];
    gvfs.enable = true;
  };

  security.polkit.enable = true;

}

