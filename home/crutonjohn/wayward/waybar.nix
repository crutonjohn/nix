{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
              * {
                font-family: Noto Sans Mono, Material Symbols Sharp;
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
        #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                padding-left: 10px;
                padding-right: 10px;
              }
              /* #mode { */
              /* 	margin-left: 10px; */
              /* 	background-color: rgb(248, 189, 150); */
              /*     color: rgb(26, 24, 38); */
              /* } */
        #memory {
                color: rgb(181, 232, 224);
              }
        #cpu {
                color: rgb(245, 194, 231);
              }
        #window {
                color: rgb(245, 224, 220);
                padding-right: 20px;
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
                font-family: "Hack Nerd Font" ;
              }
    '';
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "wlr/workspaces"
        "temperature"
        "custom/wall"
        "mpd"
      ];
      modules-center = [
        "hyprland/window"
        "clock"
      ];
      modules-right = [
        "pulseaudio"
        "backlight"
        "memory"
        "cpu"
        "network"
        "battery"
        "custom/powermenu"
        "tray"
      ];
      "custom/launcher" = {
        "format" = " ";
        "on-click" = "pkill wofi || wofi -S drun";
        "tooltip" = false;
      };
      "hyprland/window" = {
	      "format" = "{}";
	      "separate-outputs" = true;
      };
      "wlr/workspaces" = {
        "format" = "{icon}";
        "on-click" = "activate";
        # "on-scroll-up" = "hyprctl dispatch workspace e+1";
        # "on-scroll-down" = "hyprctl dispatch workspace e-1";
      };
      "backlight" = {
        "device" = "intel_backlight";
        "on-scroll-up" = "light -A 5";
        "on-scroll-down" = "light -U 5";
        "format" = "{icon} {percent}%";
        "format-icons" = [ "" "" "" "" ];
      };
      "pulseaudio" = {
        "scroll-step" = 1;
        "format" = "{icon} {volume}%";
        "format-muted" = " Muted";
        "format-icons" = {
          "default" = [ "" "" "" ];
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
        "format" = "{icon} {capacity}%";
        "full-at" = 90;
        "format-icons" = [ "" "" "" "" "" "" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = " {capacity}%";
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
        "interval" = 1;
        "format" = " {percentage}%";
        "states" = {
          "warning" = 85;
        };
      };
      "cpu" = {
        "interval" = 1;
        "format" = " {usage}%";
      };
      "mpd" = {
        "max-length" = 25;
        "format" = "<span foreground='#bb9af7'></span> {title}";
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
        "format-wifi" = " {essid}";
        "format-ethernet" = "  {ifname} ({ipaddr})";
        "format-linked" = " {essid} (No IP)";
        "format-disconnected" = " Disconnected";
        "tooltip" = false;
      };
      "temperature" = {
        # "hwmon-path"= "${env:HWMON_PATH}";
        #"critical-threshold"= 80;
        "tooltip" = false;
        "format" = " {temperatureC}°C";
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
