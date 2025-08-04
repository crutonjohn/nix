{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    # font-family: 0xProto Nerd Font Mono, Material Symbols Sharp;
    style = ''
        * {
              font-family: "0xProto Nerd Font Mono";
              font-size: 12pt;
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
                background-color: rgb(30, 30, 46);
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
              tooltip {
                background: rgb(48, 45, 65);
              }
              tooltip label {
                color: rgb(217, 224, 238);
              }
        #custom-launcher {
                font-size: 20px;
                padding-left: 8px;
                padding-right: 6px;
                color: #7ebae4;
              }
        #mode, #clock, #memory, #cpu, #custom-gpu, #mpd, #custom-wall, #temperature.cpu, #temperature.gpu, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                padding-left: 10px;
                padding-right: 10px;
              }
        #memory {
                color: rgb(181, 232, 224);
              }
        #cpu, #temperature.cpu {
                color: rgb(245, 194, 231);
              }
        #window {
                color: rgb(245, 224, 220);
                padding-right: 20px;
              }
        #clock {
                color: rgb(217, 224, 238);
              }
        #custom-gpu, #temperature.gpu {
                color: rgb(150, 205, 251);
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
        #mpd.paused {
                color: #414868;
                font-style: italic;
              }
        #mpd.stopped {
                background: transparent;
              }
        #mpd {
                color: #c0caf5;
              }
        #custom-cava-internal{
                font-family: "0xProto Nerd Font Mono" ;
              }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "hyprland/workspaces"
        #"custom/wall"
        "mpd"
      ];
      modules-center = [
        "hyprland/window"
        "clock"
      ];
      modules-right = [
        "custom/gpu"
        "temperature#gpu"
        "memory"
        "cpu"
        "temperature#cpu"
        "network"
        "battery"
        "pulseaudio"
        "custom/powermenu"
        "tray"
      ];
      "custom/launcher" = {
        "format" = "<span font='24'></span> ";
        "on-click" = "pkill wofi || wofi -S drun";
        "tooltip" = false;
      };
      "hyprland/window" = {
        "format" = "{title}";
        "separate-outputs" = true;
      };
      "hyprland/workspaces" = {
        "format" = "{icon}";
        "move-to-monitor" = true;
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "<span font='18'>{icon}</span> {volume}%";
        "format-muted" = "<span font='18'>󰝟</span> Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
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
        "format" = "<span font='18'>{icon}</span> {capacity}%";
        "full-at" = 90;
        "format-icons" = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" ];
        "format-full" = "<span font='18'>{icon}</span> {capacity}%";
        "format-charging" = "<span font='18'>󱐋</span> {capacity}%";
        "tooltip" = true;
        "tooltip-format" = "{time}";
      };
      "clock" = {
        "interval" = 1;
        "format" = "{:%I:%M %p  %A %b %d}";
        "tooltip" = true;
        "tooltip-format" = "\n<tt>{calendar}</tt>";
      };
      "memory" = {
        "interval" = 5;
        "format" = "<span font='18'></span> {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "mpd" = {
        "max-length" = 25;
        "format" = "<span foreground='#bb9af7' font='18'></span> {title}";
        "format-paused" = " {title}";
        "format-stopped" = "<span foreground='#bb9af7'></span>";
        "format-disconnected" = "";
        "on-click" = "mpc --quiet toggle";
        "on-click-right" = "mpc update; mpc ls | mpc add";
        "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
        "on-scroll-up" = "mpc --quiet prev";
        "on-scroll-down" = "mpc --quiet next";
        "smooth-scrolling-threshold" = 5;
        "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
      };
      "network" = {
        "interval" = 1;
        "format-wifi" = "<span font='18'>󰌗</span> {essid}";
        "format-ethernet" = "<span font='18'>󰌗</span> {ifname} ({ipaddr})";
        "format-linked" = "<span font='18'>󰤩</span> {essid} (No IP)";
        "format-disconnected" = "<span font='18'>󰤮</span> Disconnected";
        "tooltip" = false;
      };
      "cpu" = {
        "interval" = 5;
        "format" = "<span font='18'></span> {usage}%";
      };
      "temperature#cpu" = {
        "hwmon-path"= "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon6/temp1_input";
        "critical-threshold"= 80;
        "tooltip" = false;
        "format" = "<span font='12'></span> {temperatureC}°C";
      };
      "custom/gpu" = {
        "exec" = "cat /sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/hwmon0/device/gpu_busy_percent";
        "format" = "<span font='17'>󰘚</span> {}%";
        "return-type" = "";
        "interval" = 5;
      };
      "temperature#gpu" = {
        "hwmon-path"= "/sys/devices/pci0000:00/0000:00:01.1/0000:01:00.0/0000:02:00.0/0000:03:00.0/hwmon/hwmon0/temp1_input";
        "critical-threshold"= 90;
        "tooltip" = false;
        "format" = "<span font='12'></span> {temperatureC}°C";
      };
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill wofi || wofi-powermenu";
        "tooltip" = false;
      };
      "tray" = {
        "icon-size" = 15;
        "spacing" = 10;
      };
    }];
  };
}
