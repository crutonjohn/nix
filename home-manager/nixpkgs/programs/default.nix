{ config, lib, pkgs, nixpkgs, ...}:{

## Web Browsers ##

programs = {
  firefox = {
    enable = true;
 };
};

## Media ##

#obs-studio = {
#    programs.obs-studio.enable = true;
#    programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
#      wlrobs
#    ];
#    # needed for screen selection on wayland
#    home.packages = [ pkgs.slurp ];
#  };

home.packages = [ pkgs.rofi-wayland pkgs.eww pkgs.dunst pkgs.flameshot pkgs.picom-next pkgs.xfce.xfce4-power-manager pkgs.polkit_gnome pkgs.nitrogen pkgs.mate.mate-polkit pkgs.polybar pkgs.swaybg pkgs.waybar pkgs.killall  pkgs.lxappearance-gtk2 pkgs.unzip pkgs.xfce.thunar pkgs.grim pkgs.slurp pkgs.wl-color-picker pkgs.wl-clipboard
];

}
