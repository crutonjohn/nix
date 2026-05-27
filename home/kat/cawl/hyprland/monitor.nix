{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        # For LAN 1080p Monitor
        # "DP-2, 1920x1080@144.00, 0x0, 1"
        # For at-home usage
        "DP-2, 3840x2160@144.00, 0x0, 1.5, transform, 1"
        "DP-1, 5120x1440@119.99900, 1440x790, 1"
        "DP-1, addreserved, 0, 0, 1280, 1280"
      ];
    };
  };
}
