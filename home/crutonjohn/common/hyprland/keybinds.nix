{ pkgs, inputs, ... }:
{

  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # Launchers & System
        "SUPER,RETURN,exec,alacritty"
        "SUPER,SPACE,exec,wofi -S drun"
        "SUPER_SHIFT,R,exec,hyprctl reload && pkill -l USR2 waybar"
        "SUPER_SHIFT,Escape,exit,"
        "SUPER_SHIFT,Q,killactive,"
        "SUPER_SHIFT,Space,togglefloating,"
        "SUPER,F,fullscreen"
        "SUPER,Y,pin"
        "SUPER,L,exec,hyprlock"

        # Layouts and groups
        "SUPER,K,togglegroup,"
        "SUPER,Tab,cyclenext,"

        # Gaps
        ''SUPER_SHIFT,G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"''
        ''SUPER,G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"''

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
        "SUPER,0,workspace,gaming"
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
        "SUPER_SHIFT,left,movewindow,l"
        "SUPER_SHIFT,right,movewindow,r"
        "SUPER_SHIFT,up,movewindow,u"
        "SUPER_SHIFT,down,movewindow,d"

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
        "SUPER:CTRL,0,movetoworkspace,gaming"
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
        "SUPER SHIFT,0,movetoworkspacesilent,gaming"

        # Scroll workspaces
        "SUPER,mouse_down,workspace,e+1"
        "SUPER,mouse_up,workspace,e-1"

        # Toggle workspace
        "SUPER,slash,workspace,previous"

        # App shortcuts
        ",Print,exec,grimblast --notify --cursor copy screen ~/Pictures/$(date '+%Y-%m-%dT%H:%M:%S_no_watermark').png"
        "SHIFT,Print,exec,grimblast --notify copy area"
        "SUPER:,Super_L,exec,bash ~/.config/rofi/powermenu.sh"

        # Media keys
        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
        ",XF86AudioMute,exec,pamixer -t"
        ",XF86AudioMicMute,exec,pamixer --default-source -t"
        #",XF86MonBrightnessUp,exec,brightnessctl -d intel_backlight s +10%"
        #",XF86MonBrightnessDown,exec,brightnessctl -d intel_backlight s 10%-"
        ",XF86AudioPlay,exec,mpc -q toggle"
        ",XF86AudioNext,exec,mpc -q next"
        ",XF86AudioPrev,exec,mpc -q prev"

        # Waybar
        "SUPER,O,exec,pkill -l USR1 waybar"

        # Resize with submap
        #"ALT,R,submap,resize"
        #"ALT SHIFT,R,exec,notify-send 'Exited resize mode'; submap,reset"
        #"ALT SHIFT,R,submap,reset"
        "CTRL SHIFT,left,resizeactive,-30 0"
        "CTRL SHIFT,right,resizeactive,30 0"
        "CTRL SHIFT,up,resizeactive,0 -30"
        "CTRL SHIFT,down,resizeactive,0 30"
        "CTRL SHIFT,l,resizeactive,30 0"
        "CTRL SHIFT,h,resizeactive,-30 0"
        "CTRL SHIFT,k,resizeactive,0 -30"
        "CTRL SHIFT,j,resizeactive,0 30"
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
    };
  };
}
