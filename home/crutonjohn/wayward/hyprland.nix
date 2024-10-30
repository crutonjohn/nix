{ config, lib, pkgs, inputs, outputs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system};
in
{

  home.file.".config/wall.jpg".source = ./bg;

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
        font-family: FiraCode Nerd Font Mono;
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
  home.file = {
    hyprland = {
      enable = true;
      target = ".config/hypr/hyprland.conf";
      text = ''
        # $scripts=$HOME/.config/hypr/scripts

        #env = WLR_DRM_DEVICES,$HOME/.config/hypr/card

        monitor=eDP-1, preferred, auto, 1.566667
        monitor=DP-1, 5120x1440, auto, 1.25

        # Lid Based docking options
        bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, preferred, auto, 1.5"
        bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"
        # monitor=HDMI-A-1, 1920x1080, 0x0, 1
        # monitor=eDP-1, 1920x1080, 1920x0, 1

        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf

        input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options = caps:escape
          kb_rules =

          follow_mouse = 2 # 0|1|2|3
          float_switch_override_focus = 2
          numlock_by_default = true

          touchpad {
          disable_while_typing=1
          natural_scroll=1
          clickfinger_behavior=1
          tap-to-click=0
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }

        general {
          gaps_in = 3
          gaps_out = 5
          border_size = 2
          col.active_border = rgb(ffc0cb)
          col.inactive_border = rgba(595959aa)

          layout = dwindle # master|dwindle
        }

        dwindle {
          no_gaps_when_only = false
          force_split = 0
          special_scale_factor = 0.8
          split_width_multiplier = 1.0
          use_active_for_splits = true
          pseudotile = yes
          preserve_split = yes
        }

        master {
          new_on_top = true
          special_scale_factor = 0.8
          no_gaps_when_only = false
        }

        # cursor_inactive_timeout = 0
        decoration {
          active_opacity = 1.0
          inactive_opacity = 1.0
          fullscreen_opacity = 1.0
          rounding = 2
          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          shadow_ignore_window = true
        # col.shadow =
        # col.shadow_inactive
        # shadow_offset
          dim_inactive = false
        # dim_strength = #0.0 ~ 1.0
          col.shadow = rgba(1a1a1aee)
          blur {
            enabled = true
            size = 3
            passes = 1
            ignore_opacity = false
            new_optimizations = true
            xray = true
          }
        }

        animations {
          enabled=1
          bezier = overshot, 0.13, 0.99, 0.29, 1.1
          animation = windows, 1, 4, overshot, slide
          animation = windowsOut, 1, 5, default, popin 80%
          animation = border, 1, 5, default
          animation = fade, 1, 8, default
          animation = workspaces, 1, 6, overshot, slidevert
        }

        gestures {
          workspace_swipe = true
          workspace_swipe_fingers = 3
          workspace_swipe_distance = 250
          workspace_swipe_invert = true
          workspace_swipe_min_speed_to_force = 15
          workspace_swipe_cancel_ratio = 0.5
          workspace_swipe_create_new = false
        }

        misc {
          disable_autoreload = true
          disable_hyprland_logo = true
          always_follow_on_dnd = true
          layers_hog_keyboard_focus = true
          animate_manual_resizes = false
          enable_swallow = true
          swallow_regex =
          focus_on_activate = true
        }

        bind = SUPER,RETURN,exec,alacritty
        bind = SUPER,SPACE,exec,wofi -S drun
        bind = SUPER_SHIFT,Return,exec,alacritty --class="termfloat"
        bind = SUPER_SHIFT,R,exec,hyprctl reload && pkill -l USR2 waybar
        bind = SUPER_SHIFT,Escape,exit,
        bind = SUPER_SHIFT,Q,killactive,
        bind = SUPER_SHIFT,Space,togglefloating,
        bind = SUPER,F,fullscreen
        bind = SUPER,Y,pin

        #-----------------------#
        # Toggle grouped layout #
        #-----------------------#
        bind = SUPER, K, togglegroup,
        bind = SUPER, Tab, cyclenext,

        #------------#
        # change gap #
        #------------#
        bind = SUPER SHIFT, G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
        bind = SUPER , G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

        #--------------------------------------#
        # Move focus with mainMod + arrow keys #
        #--------------------------------------#
        bind = SUPER, left, movefocus, l
        bind = SUPER, right, movefocus, r
        bind = SUPER, up, movefocus, u
        bind = SUPER, down, movefocus, d

        #----------------------------------------#
        # Switch workspaces with mainMod + [0-9] #
        #----------------------------------------#
        bind = SUPER, 1, workspace, 1
        bind = SUPER, 2, workspace, 2
        bind = SUPER, 3, workspace, 3
        bind = SUPER, 4, workspace, 4
        bind = SUPER, 5, workspace, 5
        bind = SUPER, 6, workspace, 6
        bind = SUPER, 7, workspace, 7
        bind = SUPER, 8, workspace, 8
        bind = SUPER, 9, workspace, 9
        bind = SUPER, 0, workspace, 10
        bind = SUPER, L, workspace, +1
        bind = SUPER, H, workspace, -1
        bind = SUPER, period, workspace, e+1
        bind = SUPER, comma, workspace,e-1
        bind = SUPER, Q, workspace,QQ
        bind = SUPER, T, workspace,TG
        bind = SUPER, M, workspace,Music

        #-------------------------------#
        # special workspace(scratchpad) #
        #-------------------------------#
        bind = SUPER, minus, movetoworkspace,special
        bind = SUPER, equal, togglespecialworkspace

        #----------------------------------#
        # move window in current workspace #
        #----------------------------------#
        bind = SUPER SHIFT,left ,movewindow, l
        bind = SUPER SHIFT,right ,movewindow, r
        bind = SUPER SHIFT,up ,movewindow, u
        bind = SUPER SHIFT,down ,movewindow, d

        #---------------------------------------------------------------#
        # Move active window to a workspace with mainMod + ctrl + [0-9] #
        #---------------------------------------------------------------#
        bind = SUPER:CTRL,1,movetoworkspace,1
        bind = SUPER:CTRL,2,movetoworkspace,2
        bind = SUPER:CTRL,3,movetoworkspace,3
        bind = SUPER:CTRL,4,movetoworkspace,4
        bind = SUPER:CTRL,5,movetoworkspace,5
        bind = SUPER:CTRL,6,movetoworkspace,6
        bind = SUPER:CTRL,7,movetoworkspace,7
        bind = SUPER:CTRL,8,movetoworkspace,8
        bind = SUPER:CTRL,9,movetoworkspace,9
        bind = SUPER:CTRL,0,movetoworkspace,10
        bind = SUPER:CTRL,left,movetoworkspace,-1
        bind = SUPER:CTRL,right,movetoworkspace,+1
        # same as above, but doesnt switch to the workspace
        bind = SUPER SHIFT,1,movetoworkspacesilent,1
        bind = SUPER SHIFT,2,movetoworkspacesilent,2
        bind = SUPER SHIFT,3,movetoworkspacesilent,3
        bind = SUPER SHIFT,4,movetoworkspacesilent,4
        bind = SUPER SHIFT,5,movetoworkspacesilent,5
        bind = SUPER SHIFT,6,movetoworkspacesilent,6
        bind = SUPER SHIFT,7,movetoworkspacesilent,7
        bind = SUPER SHIFT,8,movetoworkspacesilent,8
        bind = SUPER SHIFT,9,movetoworkspacesilent,9
        bind = SUPER SHIFT,0,movetoworkspacesilent,10
        # Scroll through existing workspaces with mainMod + scroll
        bind = SUPER,mouse_down,workspace,e+1
        bind = SUPER,mouse_up,workspace,e-1

        #-------------------------------------------#
        # switch between current and last workspace #
        #-------------------------------------------#
        binds {
             workspace_back_and_forth = 1
             allow_workspace_cycles = 1
        }
        bind=SUPER,slash,workspace,previous

        #------------------------#
        # quickly launch program #
        #------------------------#
        bind=SUPER,B,exec,firefox
        bind=SUPER SHIFT,X,exec,myswaylock
        bind=,Print,exec,grimblast --notify --cursor  copy screen ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
        bind=SHIFT,Print,exec,grimblast --notify --cursor copy area
        bind=SUPER,bracketright,exec, grimblast --notify --cursor  copy area
        bind=SUPER,A,exec,grimblast_watermark
        bind=SUPER:,Super_L,exec, bash ~/.config/rofi/powermenu.sh

        #-----------------------------------------#
        # control volume,brightness,media players-#
        #-----------------------------------------#
        bind=,XF86AudioRaiseVolume,exec, pamixer -i 5
        bind=,XF86AudioLowerVolume,exec, pamixer -d 5
        bind=,XF86AudioMute,exec, pamixer -t
        bind=,XF86AudioMicMute,exec, pamixer --default-source -t
        bind=,XF86MonBrightnessUp,exec, brightnessctl -d intel_backlight s +10%
        bind=,XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight s 10%-
        bind=,XF86AudioPlay,exec, mpc -q toggle
        bind=,XF86AudioNext,exec, mpc -q next
        bind=,XF86AudioPrev,exec, mpc -q prev

        #---------------#
        # waybar toggle #
        # --------------#
        bind=SUPER,O,exec,pkill -l USR1 waybar

        #---------------#
        # resize window #
        #---------------#
        bind=ALT,R,submap,resize
        submap=resize
        binde=,right,resizeactive,15 0
        binde=,left,resizeactive,-15 0
        binde=,up,resizeactive,0 -15
        binde=,down,resizeactive,0 15
        binde=,l,resizeactive,15 0
        binde=,h,resizeactive,-15 0
        binde=,k,resizeactive,0 -15
        binde=,j,resizeactive,0 15
        bind=,escape,submap,reset
        submap=reset

        bind=CTRL SHIFT, left, resizeactive,-15 0
        bind=CTRL SHIFT, right, resizeactive,15 0
        bind=CTRL SHIFT, up, resizeactive,0 -15
        bind=CTRL SHIFT, down, resizeactive,0 15
        bind=CTRL SHIFT, l, resizeactive, 15 0
        bind=CTRL SHIFT, h, resizeactive,-15 0
        bind=CTRL SHIFT, k, resizeactive, 0 -15
        bind=CTRL SHIFT, j, resizeactive, 0 15

        bindm = SUPER, mouse:272, movewindow
        bindm = SUPER, mouse:273, resizewindow

        #------#
        # wall #
        #------#
        exec-once = hyprpaper &
        exec-once = hyprctl hyprpaper wallpaper "eDP-1,~/.config/wall"

        #------------#
        # auto start #
        #------------#
        exec-once = waybar --config ~/.config/waybar/config &
        exec-once = nm-applet --indicator &

        #---------------#
        # windows rules #
        #---------------#
        #`hyprctl clients` get class、title...
        windowrule=float,title:^(Picture-in-Picture)$
        windowrule=size 960 540,title:^(Picture-in-Picture)$
        windowrule=move 25%-,title:^(Picture-in-Picture)$
        windowrule=float,imv
        windowrule=move 25%-,imv
        windowrule=size 960 540,imv
        windowrule=float,mpv
        windowrule=move 25%-,mpv
        windowrule=size 960 540,mpv
        windowrule=float,danmufloat
        windowrule=move 25%-,danmufloat
        windowrule=pin,danmufloat
        windowrule=rounding 5,danmufloat
        windowrule=size 960 540,danmufloat
        windowrule=float,termfloat
        windowrule=move 25%-,termfloat
        windowrule=size 960 540,termfloat
        windowrule=rounding 5,termfloat
        windowrule=float,nemo
        windowrule=move 25%-,nemo
        windowrule=size 960 540,nemo
        windowrule=opacity 0.95,title:Telegram
        windowrule=opacity 0.95,title:QQ
        windowrule=opacity 0.95,title:NetEase Cloud Music Gtk4
        windowrule=animation slide right,kitty
        windowrule=workspace name:QQ, title:Icalingua++
        windowrule=workspace name:TG, title:Telegram
        windowrule=workspace name:Music, title:NetEase Cloud Music Gtk4
        windowrule=workspace name:Music, musicfox
        windowrule=float,ncmpcpp
        windowrule=move 25%-,ncmpcpp
        windowrule=size 960 540,ncmpcpp
        windowrule=noblur,^(firefox)$
      '';
    };
    hyprpaper = {
      enable = true;
      target = ".config/hypr/hyprpaper.conf";
      text = ''
        preload = ~/.config/wall.jpg
        # .. more preloads
        #set the default wallpaper(s) seen on inital workspace(s) --depending on the number of monitors used
        wallpaper = eDP-1,~/.config/wall.jpg
      '';
    };
  };
}
