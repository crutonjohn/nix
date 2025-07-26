{ config, lib, pkgs, inputs, outputs, ... }:
{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # needed due to https://github.com/hyprwm/Hyprland/discussions/4768
    extraConfig = ''
      # built in touchpad
      device {
        name=pixa3854:00-093a:0274-touchpad
        tap-to-click=false
      }
      plugin:hyprexpo {
            enabled = true
            columns = 3
            gap_size = 5
            bg_col = rgb(ffc0cb)
            workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

            enable_gesture = true
            gesture_fingers = 4
            gesture_distance = 300 # how far is the "max"
            gesture_positive = false # positive = swipe down. Negative = swipe up.
      }
    '';
    settings = {
      monitor = [
        "eDP-1, preferred, auto, 1.566667"
        "DP-1, 5120x1440, auto, 1.25"
      ];

      bindl = [
        ",switch:off:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, preferred, auto, 1.5\""
        ",switch:on:Lid Switch,exec,hyprctl keyword monitor \"eDP-1, disable\""
      ];

      input = {
        kb_layout = "us";
        kb_options = "caps:escape";
        follow_mouse = 2;
        float_switch_override_focus = 2;
        numlock_by_default = true;
        sensitivity = 0.0;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          clickfinger_behavior = 1;
          tap-to-click = false;
        };
      };

      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        layout = "dwindle";
        "col.active_border" = "rgb(ffc0cb)";
        "col.inactive_border" = "rgba(595959aa)";
      };

      dwindle = {
        force_split = false;
        special_scale_factor = 0.8;
        split_width_multiplier = 1.0;
        use_active_for_splits = true;
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_on_top = true;
        special_scale_factor = 0.8;
      };

      decoration = {
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        rounding = 5;
        rounding_power = 2;
        dim_inactive = false;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          ignore_opacity = false;
          new_optimizations = true;
          xray = true;
        };
      };

      animations = {
        enabled = true;
        bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
        animation = [
          "windows, 1, 4, overshot, slide"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 5, default"
          "fade, 1, 8, default"
          "workspaces, 1, 6, overshot, slidevert"
        ];
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 15;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };

      misc = {
        disable_autoreload = true;
        disable_hyprland_logo = true;
        always_follow_on_dnd = true;
        layers_hog_keyboard_focus = true;
        animate_manual_resizes = false;
        enable_swallow = true;
        swallow_regex = "";
        focus_on_activate = true;
      };

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };

      bind = [
        # Launchers & System
        "SUPER,RETURN,exec,alacritty"
        "SUPER,SPACE,exec,wofi -S drun"
        "SUPER_SHIFT,Return,exec,alacritty --class=\"termfloat\""
        "SUPER_SHIFT,R,exec,hyprctl reload && pkill -l USR2 waybar"
        "SUPER_SHIFT,Escape,exit,"
        "SUPER_SHIFT,Q,killactive,"
        "SUPER_SHIFT,Space,togglefloating,"
        "SUPER,F,fullscreen"
        "SUPER,Y,pin"

        # Layouts and groups
        "SUPER,K,togglegroup,"
        "SUPER,Tab,cyclenext,"

        # Gaps
        "SUPER SHIFT,G,exec,hyprctl --batch \"keyword general:gaps_out 5;keyword general:gaps_in 3\""
        "SUPER,G,exec,hyprctl --batch \"keyword general:gaps_out 0;keyword general:gaps_in 0\""

        # Focus movement
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        # Workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"
        "SUPER,L,workspace,+1"
        "SUPER,H,workspace,-1"
        "SUPER,period,workspace,e+1"
        "SUPER,comma,workspace,e-1"
        "SUPER,Q,workspace,QQ"
        "SUPER,T,workspace,TG"
        "SUPER,M,workspace,Music"

        # Special workspace
        "SUPER,minus,movetoworkspace,special"
        "SUPER,equal,togglespecialworkspace"

        # Move window
        "SUPER SHIFT,left,movewindow,l"
        "SUPER SHIFT,right,movewindow,r"
        "SUPER SHIFT,up,movewindow,u"
        "SUPER SHIFT,down,movewindow,d"

        # Move window to workspace
        "SUPER:CTRL,1,movetoworkspace,1"
        "SUPER:CTRL,2,movetoworkspace,2"
        "SUPER:CTRL,3,movetoworkspace,3"
        "SUPER:CTRL,4,movetoworkspace,4"
        "SUPER:CTRL,5,movetoworkspace,5"
        "SUPER:CTRL,6,movetoworkspace,6"
        "SUPER:CTRL,7,movetoworkspace,7"
        "SUPER:CTRL,8,movetoworkspace,8"
        "SUPER:CTRL,9,movetoworkspace,9"
        "SUPER:CTRL,0,movetoworkspace,10"
        "SUPER:CTRL,left,movetoworkspace,-1"
        "SUPER:CTRL,right,movetoworkspace,+1"

        # Silent workspace move
        "SUPER SHIFT,1,movetoworkspacesilent,1"
        "SUPER SHIFT,2,movetoworkspacesilent,2"
        "SUPER SHIFT,3,movetoworkspacesilent,3"
        "SUPER SHIFT,4,movetoworkspacesilent,4"
        "SUPER SHIFT,5,movetoworkspacesilent,5"
        "SUPER SHIFT,6,movetoworkspacesilent,6"
        "SUPER SHIFT,7,movetoworkspacesilent,7"
        "SUPER SHIFT,8,movetoworkspacesilent,8"
        "SUPER SHIFT,9,movetoworkspacesilent,9"
        "SUPER SHIFT,0,movetoworkspacesilent,10"

        # Scroll workspaces
        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

        # Toggle workspace
        "SUPER,slash,workspace,previous"

        # App shortcuts
        "SUPER,B,exec,firefox"
        "SUPER SHIFT,X,exec,myswaylock"
        ",Print,exec,grimblast --notify --cursor copy screen ~/Pictures/$(date '+%Y-%m-%dT%H:%M:%S_no_watermark').png"
        "SHIFT,Print,exec,grimblast --notify --cursor copy area"
        "SUPER,bracketright,exec,grimblast --notify --cursor copy area"
        "SUPER,A,exec,grimblast_watermark"
        "SUPER:,Super_L,exec,bash ~/.config/rofi/powermenu.sh"

        # Media keys
        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
        ",XF86AudioMute,exec,pamixer -t"
        ",XF86AudioMicMute,exec,pamixer --default-source -t"
        ",XF86MonBrightnessUp,exec,brightnessctl -d intel_backlight s +10%"
        ",XF86MonBrightnessDown,exec,brightnessctl -d intel_backlight s 10%-"
        ",XF86AudioPlay,exec,mpc -q toggle"
        ",XF86AudioNext,exec,mpc -q next"
        ",XF86AudioPrev,exec,mpc -q prev"

        # Waybar
        "SUPER,O,exec,pkill -l USR1 waybar"

        # Resize with submap
        #"ALT,R,submap,resize"
        #"ALT SHIFT,R,exec,notify-send 'Exited resize mode'; submap,reset"
        #"ALT SHIFT,R,submap,reset"
        "CTRL SHIFT,left,resizeactive,-15 0"
        "CTRL SHIFT,right,resizeactive,15 0"
        "CTRL SHIFT,up,resizeactive,0 -15"
        "CTRL SHIFT,down,resizeactive,0 15"
        "CTRL SHIFT,l,resizeactive,15 0"
        "CTRL SHIFT,h,resizeactive,-15 0"
        "CTRL SHIFT,k,resizeactive,0 -15"
        "CTRL SHIFT,j,resizeactive,0 15"
      ];

      #submap = {
      #  resize = {
      #    binde = [
      #      ",right,resizeactive,15 0"
      #      ",left,resizeactive,-15 0"
      #      ",up,resizeactive,0 -15"
      #      ",down,resizeactive,0 15"
      #      ",l,resizeactive,15 0"
      #      ",h,resizeactive,-15 0"
      #      ",k,resizeactive,0 -15"
      #      ",j,resizeactive,0 15"
      #    ];
      #    bind = [
      #      ",escape,submap,reset"
      #      ",r,submap,reset"
      #    ];
      #  };
      #  reset = {};
      #};

      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      exec-once = [
        "hyprpaper &"
        "hyprctl hyprpaper wallpaper \"eDP-1,~/.config/wall\""
        "waybar --config ~/.config/waybar/config &"
        "nm-applet --indicator &"
      ];

      windowrule = [
        "float,title:^(Picture-in-Picture)$"
        "size 960 540,title:^(Picture-in-Picture)$"
        "move 25%-,title:^(Picture-in-Picture)$"
      ];
    };
    plugins = [
      # https://github.com/KZDKM/Hyprspace
      # disabled due to https://github.com/KZDKM/Hyprspace/issues/184
      #inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];

  };

  # Wallpaper/Hyprpaper
  home.file.".config/mobile.jpg".source = ./wallpapers/mobile;
  home.file.".config/docked.jpg".source = ./wallpapers/docked;
  services.hyprpaper = {
    enable = true;
    settings = {
      preload =
        [ "/home/crutonjohn/.config/wall.jpg" ];
      wallpaper = [
        "eDP-1,~/.config/mobile.jpg"
        "DP-1,~/.config/docked.jpg"
      ];
    };
  };



  imports = [
    ./hyprland-variables.nix
    ./waybar.nix
  ];

  programs.wofi = {
    enable = true;
    settings = {
      location = "bottom-right";
      allow_markup = true;
      width = 250;
    };
    style = ''
      * {
        font-family: 0xProto Nerd Font Mono;
      }
      window {
        background-color: #7c818c;
      }
    '';
  };

  programs = {
    fish.loginShellInit = ''
      if test (tty) = "/dev/tty1"
        exec Hyprland &> /dev/null
      end
    '';
    zsh.loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
    zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &> /dev/null
      fi
    '';
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "808080";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
}
