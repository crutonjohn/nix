{ ... }:
{

  wayland.windowManager.hyprland = {
    settings = {
      exec-once = [
        # "hyprpaper &"
        # ''hyprctl hyprpaper wallpaper "DP-1,~/.config/wallpaper.jpg"''
        # ''hyprctl hyprpaper wallpaper "DP-2,~/.config/wallpaper.jpg"''
        "waybar --config ~/.config/waybar/config &"
        "nm-applet --indicator &"
        # auto toggle waybar on gaming workspace
        # "/etc/profiles/per-user/crutonjohn/bin/hyprland-gaming-auto-waybar-toggle &>/dev/null"
        # autostart programs #
        # "hyprland-gaming-init"
        ######################
      ];
    };
  };
}
