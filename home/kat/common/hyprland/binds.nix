{ pkgs, inputs, ... }:
{

  wayland.windowManager.hyprland = {
    settings = {
      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };
      bind = [
        # Launchers & System
        "SUPER,RETURN,exec,alacritty"
    };
  };
}
