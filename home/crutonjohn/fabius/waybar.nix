{
  config,
  lib,
  pkgs,
  ...
}:

{

  wayland.windowManager.hyprland = {
    settings = {

      exec = [
        "pgrep waybar >/dev/null || waybar --config ~/.config/waybar/config &"
      ];

    };
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    # font-family: 0xProto Nerd Font Mono, Material Symbols Sharp;
    style = ''
      * {
          font-family: "0xProto Nerd Font Propo";
          font-size: 12pt;
          font-weight: bold;
          border-radius: 0px;
          transition-property: background-color;
          transition-duration: 0.5s;
      }

      tooltip {
          background: rgba(30, 30, 46, 0.5);
          border: 1px solid rgba(217, 224, 238, 0.5);
          border-radius: 8px;
      }

      tooltip label {
        color: rgb(217, 224, 238);
      }

      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
        }
      }

      .warning, .critical, .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      window#waybar {
        background-color: transparent;
      }

      window > box {
        margin-left: 5px;
        margin-right: 5px;
        margin-top: 5px;
        background-color: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background-color: rgb(30, 30, 46);
        border-radius: 8px;
        padding-left: 2px;
        padding-right: 2px;
      }

      #workspaces {
        padding-left: 0px;
        padding-right: 4px;
      }
      #workspaces button {
        padding-top: 5px;
        padding-bottom: 5px;
        padding-left: 6px;
        padding-right: 6px;
      }

      #workspaces button.active {
        background-color: rgb(181, 232, 224);
        color: rgb(26, 24, 38);
      }

      #workspaces button.urgent {
        color: rgb(26, 24, 38);
      }

      #workspaces button:hover {
        background-color: rgb(248, 189, 150);
        color: rgb(26, 24, 38);
      }

      #custom-launcher {
        font-size: 20px;
        padding-left: 8px;
        padding-right: 6px;
        color: #7ebae4;
      }

      #mode,
      #clock,
      #memory,
      #temperature,
      #cpu,
      #mpd,
      #custom-wall
      #temperature,
      #backlight,
      #pulseaudio,
      #network,
      #battery,
      #custom-powermenu,
      #custom-cava-internal {
        padding-left: 4px;
        padding-right: 4px;
      }

      #cpu, #custom-gpu, #memory {
      }

      #temperature.cpu, #temperature.gpu {
      }

      #memory {
        color: rgb(181, 232, 224);
      }

      #cpu, #temperature.cpu {
        color: rgb(245, 194, 231);
      }

      #custom-gpu, #temperature.gpu {
        color: rgb(150, 205, 251);
      }

      #pulseaudio {
        color: rgb(245, 224, 220);
      }

      #window {
        color: rgb(245, 224, 220);
        padding-right: 20px;
      }

      #clock {
        color: rgb(217, 224, 238);
      }

      #network {
        color: rgb(171, 233, 179);
      }

      #network.disconnected {
        color: rgb(255, 255, 255);
      }

      #battery.charging, #battery.full, #battery.discharging {
        color: rgb(250, 227, 176);
      }

      #battery.critical:not(.charging) {
        color: rgb(242, 143, 173);
      }

      #custom-powermenu {
        color: rgb(242, 143, 173);
      }

      #tray {
        padding-right: 8px;
        padding-left: 10px;
        background-color: rgb(181, 232, 224);
        border-radius: 8px;
      }

      #custom-cava-internal{
        font-family: "0xProto Nerd Font Propo" ;
      }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "bottom";
        "output" = [ "DP-1" ];
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"

          "cpu"
          "temperature#cpu"

          "memory"

          "custom/gpu"
          "temperature#gpu"

          "network"

          "battery"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = "";
          "on-click" = "pkill wofi || wofi -S drun --allow-images";
          "tooltip" = false;
        };
        "hyprland/window" = {
          "format" = "{}";
          "separate-outputs" = true;
          "max-length" = 40;
          "rewrite" = {
            "(.*) — Zen Browser" = "$1";
          };
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "all-outputs" = true;
          "move-to-monitor" = true;
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "mpris" = {
          "format" = "{player_icon}{status_icon} {dynamic}";
          "dynamic-order" = [
            "title"
            "artist"
          ];
          "player-icons" = {
            "subtui" = "";
          };
          "status-icons" = {
            "playing" = "";
            "paused" = "";
            "stopped" = "";
          };
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon}{volume}%";
          "format-muted" = "Muted";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          # "states" = {
          #   "warning" = 90;
          # };
          "on-click" = "pavucontrol -t 4";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon}{capacity}%";
          "full-at" = 90;
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
          ];
          "format-full" = "󰁹{capacity}%";
          "format-charging" = "󰂄{capacity}%";
          "tooltip" = true;
          "tooltip-format" = "{timeTo}";
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%R %a%b%d}";
          "tooltip" = true;
          "tooltip-format" = "\n<tt><small>{calendar}</small></tt>";
          "calendar" = {
            "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        "network" = {
          "interval" = 1;
          "format-wifi" = "󰖩{essid}";
          "format-ethernet" = "󰈀{ifname} ({ipaddr})";
          "format-linked" = "󰤩{essid} (No IP)";
          "format-disconnected" = "󰤮";
          "tooltip" = false;
        };
        "cpu" = {
          "interval" = 5;
          "format" = "{usage}%";
        };
        "temperature#cpu" = {
          "hwmon-path" = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon6/temp1_input";
          "critical-threshold" = 80;
          "tooltip" = false;
          "format" = "{temperatureC}°C";
        };
        "memory" = {
          "interval" = 1;
          "format" = "{percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "custom/gpu" = {
          "exec" =
            "cat /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/hwmon0/device/gpu_busy_percent";
          "format" = "{}%";
          "return-type" = "";
          "interval" = 2;
        };
        "temperature#gpu" = {
          "hwmon-path" =
            "/sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/hwmon0/temp1_input";
          "critical-threshold" = 90;
          "tooltip" = false;
          "format" = "{temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "󰐥";
          "on-click" = "pkill wofi || wofi-powermenu";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 10;
        };
      }
    ];
  };
}
