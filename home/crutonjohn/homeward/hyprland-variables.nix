{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "vim";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
      # GTK_IM_MODULE = "fcitx5";
      # QT_IM_MODULE = "fcitx5";
      # XMODIFIERS = "@im=fcitx5";
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      # WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line  
      CLUTTER_BACKEND = "wayland";
      # LIBVA_DRIVER_NAME = "nvidia";
      WLR_RENDERER = "vulkan";
      WLR_DRM_DEVICES = /dev/dri/card0
      #__NV_PRIME_RENDER_OFFLOAD="1";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
    };
    sessionPath = [
      "$HOME/.npm-global/bin"
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.krew/bin"
    ];
  };
}
