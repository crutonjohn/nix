{ ... }:

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
    style = ''
      * {
              font-family: "0xProto Nerd Font Propo";
              font-size: 9pt;
              font-weight: bold;
              border-radius: 0px;
              transition-property: background-color;
              transition-duration: 0.5s;
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
      #workspaces {
              padding-left: 0px;
              padding-right: 4px;
            }

      .modules-left,
      .modules-center,
      .modules-right {
              background-color: rgb(30, 30, 46);
              border-radius: 8px;
              padding-left: 2px;
              padding-right: 2px;
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
            tooltip {
              background: rgb(48, 45, 65);
            }
            tooltip label {
              color: rgb(217, 224, 238);
            }
      #custom-launcher {
              font-size: 14px;
              padding-left: 4px;
              padding-right: 6px;
              color: #7ebae4;
              font-family: Hack Nerd Font;
            }
      #mode,
      #clock,
      #memory,
      #temperature,
      #cpu,
      #mpris,
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
      #memory {
              color: rgb(181, 232, 224);
            }
      #cpu {
              color: rgb(245, 194, 231);
            }
      #window {
              color: rgb(245, 224, 220);
              padding-right: 4px;
              padding-left: 4px;
            }
      #clock {
              color: rgb(217, 224, 238);
            }
      #temperature {
              color: rgb(150, 205, 251);
            }
      #backlight {
              color: rgb(248, 189, 150);
            }
      #pulseaudio {
              color: rgb(245, 224, 220);
            }
      #network {
              color: #ABE9B3;
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
            }
      #mpris.paused {
              color: #414868;
              font-style: italic;
            }
      #mpris.stopped {
              background: transparent;
            }
      #mpris {
              color: #c0caf5;
            }
      #custom-cava-internal{
              font-family: "Hack Nerd Font" ;
            }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "hyprland/window"
          "mpris"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "temperature"
          "network"
          "battery"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = "";
          "on-click" = "pkill wofi || wofi -S drun";
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
          "on-click" = "activate";
          # "on-scroll-up" = "hyprctl dispatch workspace e+1";
          # "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon}{percent}%";
          "format-icons" = [
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];
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
        "mpris" = {
          "format" = "{player_icon}{status_icon}";
          "tooltip-format" = "{dynamic}";
          "dynamic-order" = [
            "title"
            "artist"
          ];
          "player-icons" = {
            "SubTUI" = "";
            "Zen Browser" = "";
          };
          "status-icons" = {
            "playing" = "";
            "paused" = "";
            "stopped" = "";
          };
          # "ignored-players" = [ "firefox" ];
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
          "tooltip-format" = "\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "{percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "{usage}%";
        };
        "network" = {
          "interval" = 1;
          "format-wifi" = "󰖩{essid}";
          "format-ethernet" = "󰈀{ifname} ({ipaddr})";
          "format-linked" = "󰤩{essid} (No IP)";
          "format-disconnected" = "󰤮";
          "tooltip" = false;
        };
        "temperature" = {
          "tooltip" = false;
          "format" = "{temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "󰐥";
          "on-click" = "pkill wofi || wofi-powermenu";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 11;
          "spacing" = 6;
        };
      }
    ];
  };
}
