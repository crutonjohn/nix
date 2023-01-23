{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ../common/generic.nix
    ./git.nix
  ];

  home.username = "bjohn";
  home.homeDirectory = "/home/bjohn";


  home.packages = with pkgs; [
    _1password
    _1password-gui
    blueman
    bundix
    i3status-rust
    networkmanager_dmenu
    comma
    feh
    rofi
    polybar
    powertop
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
    picom
    scrot
    imagemagick
    pywal
    arandr
    calc
    siji
    syncthing
    syncthing-tray
    material-icons
    nerdfonts
    glibc
    pulseaudio
    gdk-pixbuf
    pasystray
    read-edid

    (pkgs.writeScriptBin "i3loadlayout" ''
    #!/usr/bin/env bash
    # workspace 1
    i3-msg "workspace 1; append_layout ~/.config/i3/ws1.json"
    (nix run github:guibou/nixGL#nixGLIntel -- alacritty)
    i3-msg "workspace 2; append_layout ~/.config/i3/ws2.json"
    (vscodium > /dev/null 2>&1 &)
    i3-msg "workspace 3; append_layout ~/.config/i3/ws3.json"
    (firefox > /dev/null 2>&1 &)
    i3-msg "workspace 4; append_layout ~/.config/i3/ws4.json"
    (slk)
    i3-msg "workspace 5;
    (webex && eaa)
    '')

    (pkgs.writeScriptBin "i3lockscreen" ''
    #!/usr/bin/env bash
    icon="$HOME/.config/i3/lockicon.png"
    tmpbg='/tmp/screen.png'
    (( $# )) && { icon=$1; }
    scrot "$tmpbg"
    convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
    i3lock -i "$tmpbg"
    rm -f "$tmpbg"
    '')

    (pkgs.writeScriptBin "launchpolybar" ''
    #!/usr/bin/env bash
    POLYBAR_DIR=$HOME/.config/polybar
    $POLYBAR_DIR/hack/launch.sh
    '')

    (pkgs.writeScriptBin "webex" ''
    #!/usr/bin/env bash
    pkill CiscoCollabHost
    /opt/Webex/bin/CiscoCollabHost
    '')

    (pkgs.writeScriptBin "slk" ''
    #!/usr/bin/env bash
    /usr/bin/slack > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "1p" ''
    #!/usr/bin/env bash
    /home/bjohn/.nix-profile/bin/1password > /dev/null 2>&1 &
    '')

    (pkgs.writeScriptBin "eaa" ''
    #!/usr/bin/env bash
    /opt/wapp/bin/EAAClient > /dev/null 2>&1 &
    '')
  ];

  services.syncthing = {
    enable = true;
    tray = {
      enable = true;
    };
  };

  ## autorandr
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "notify-i3" = "/usr/bin/i3-msg restart";
        "notify-sys" = ''
          notify-send -i display "Display profile" "$AUTORANDR_CURRENT_PROFILE"
        '';
        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            docked-*)
              DPI=108
              ;;
            mobile)
              DPI=192
              ;;
            *)
              echo "Unknown profile: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac
          echo "Xft.dpi: $DPI" | /usr/bin/xrdb -merge
        '';
      };
    };
    profiles = {
      "docked-DP2" = {
#        hooks = {
#          preswitch = {
#            "block" = "grep -q open /proc/acpi/button/lid/LID0/state";
#            "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
#          };
#        };
        fingerprint = {
          DP-2 = "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd00324b1e5a19000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a2020014b020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024";
        };
        config = {
          DP-2 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440_59.99";
            rate = "59.94";
            dpi = 108;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-3.enable = false;
          eDP-1.enable = false;
          DP-4.enable = false;
        };
      };
      "docked-DP3" = {
#        hooks = {
#          preswitch = {
#            "block" = ''
#               exec grep -q open /proc/acpi/button/lid/LID0/state
#            '';
#          };
#        };
        fingerprint = {
          DP-3 = "00ffffffffffff004c2d537000000000011e0104b57722783ac725b14b46a8260e5054bfef80714f810081c08180a9c0b3009500d1c0565e00a0a0a0295030203500a9504100001a000000fd00324b1e5a19000a202020202020000000fc004c433439473935540a20202020000000ff004831414b3530303030300a2020014b020313f146905a591f04132309070783010000023a801871382d40582c4500a9504100001e584d00b8a1381440f82c4500a9504100001e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024";
        };
        config = {
          DP-3 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "5120x1440_59.99";
            rate = "59.94";
            dpi = 108;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2.enable = false;
          eDP-1.enable = false;
          DP-4.enable = false;
        };
      };
      "mobile" = {
#        hooks = {
#          preswitch = {
#            "block" = ''
#               exec grep -q closed /proc/acpi/button/lid/LID0/state
#            '';
#          };
#        };
        fingerprint = {
          eDP-1 = "00ffffffffffff004d101615000000000a1f0104b52215780ad697af5033bb240b52540000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe004a4e4a5939804c513135365231000000000002410332011200000b010a202001af02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2400";
            rate = "59.99";
            dpi = 192;
          };
          DP-1.enable = false;
          HDMI-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
        };
      };
    };

  };


  # Locale Fixes
  home.file.".xsessionrc".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$PATH
    xset r rate 200 50
    export LOCALES_ARCHIVE=/usr/lib/locale/locale-archive
    export LOCALE_ARCHIVE_2_27=/usr/lib/locale/locale-archive
    '';

  # Scaling Fixes
  home.file.".Xresources".text = ''
    Xcursor.theme: Adwaita
    Xcursor.size: 96
    Xft.autohint: 0
    Xft.lcdfilter:  lcddefault
    Xft.hintstyle:  hintfull
    Xft.hinting: 1
    Xft.antialias: 1
    Xft.rgba: rgb
    '';
  home.file.".xinitrc".text = ''
    xrdb -merge ~/.Xresources
    xset +fp ~/.fonts/misc/
    picom -b
    '';

  # (more) Locale Fixes
  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  home.sessionVariables.LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";

  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ./i3/layout/ws1.json;
  home.file.".config/i3/ws2.json".source = ./i3/layout/ws2.json;
  home.file.".config/i3/ws3.json".source = ./i3/layout/ws3.json;
  home.file.".config/i3/ws4.json".source = ./i3/layout/ws4.json;
  home.file.".config/i3/screen_shot.sh".source = ../apps/i3/screen_shot.sh;
  home.file.".config/i3/lockicon.png".source = ../apps/i3/lockicon.png;
  home.file.".config/picom.conf".source = ../apps/picom/picom.conf;
  home.file.".config/rofi/config.rasi".source = ../apps/rofi/config.rasi;
  home.file.".config/polybar/hack" = {
    source = ./polybar/hack;
    recursive = true;
  };
  home.file.".config/polybar/material" = {
    source = ./polybar/material;
    recursive = true;
  };
  # Rofi
  home.file.".config/rofi/rofi.theme.rasi".text = ''
    * {
        bg-col:  #303446;
        bg-col-light: #303446;
        border-col: #303446;
        selected-col: #303446;
        blue: #8caaee;
        fg-col: #c6d0f5;
        fg-col2: #e78284;
        grey: #737994;

        width: 600;
        font: "Fira Code Retina Nerd Font Complete 14";
    }

    element-text, element-icon , mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }

    window {
        height: 360px;
        border: 3px;
        border-color: @border-col;
        background-color: @bg-col;
    }

    mainbox {
        background-color: @bg-col;
    }

    inputbar {
        children: [prompt,entry];
        background-color: @bg-col;
        border-radius: 5px;
        padding: 2px;
    }

    prompt {
        background-color: @blue;
        padding: 6px;
        text-color: @bg-col;
        border-radius: 3px;
        margin: 20px 0px 0px 20px;
    }

    textbox-prompt-colon {
        expand: false;
        str: ":";
    }

    entry {
        padding: 6px;
        margin: 20px 0px 0px 10px;
        text-color: @fg-col;
        background-color: @bg-col;
    }

    listview {
        border: 0px 0px 0px;
        padding: 6px 0px 0px;
        margin: 10px 0px 0px 20px;
        columns: 2;
        lines: 5;
        background-color: @bg-col;
    }

    element {
        padding: 5px;
        background-color: @bg-col;
        text-color: @fg-col  ;
    }

    element-icon {
        size: 25px;
    }

    element selected {
        background-color:  @selected-col ;
        text-color: @fg-col2  ;
    }

    mode-switcher {
        spacing: 0;
      }

    button {
        padding: 10px;
        background-color: @bg-col-light;
        text-color: @grey;
        vertical-align: 0.5;
        horizontal-align: 0.5;
    }

    button selected {
      background-color: @bg-col;
      text-color: @blue;
    }
  '';

  # Dunst
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        follow = "keyboard";
        transparency = 10;
        frame_color = "#E06C75";
        font = "Iosevka Regular 18";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        line_height = 4;
        format = "<b>%s</b>%b";
        show_age_threshold = 60;
        separator_height = 2;
        separator_color = "frame";
        markup = "full";
        ignore_newline = "no";
        word_wrap = "yes";
        alignment = "left";
      };
      urgency_low = {
        background = "#282C34";
        foreground = "#ABB2BF";
        timeout = 10;
      };
      urgency_normal = {
        background = "#282C34";
        foreground = "#ABB2BF";
        timeout = 10;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#FFFFFF";
        frame_color = "#FF0000";
        timeout = 0;
      };
    };
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  home.file.".config/wall".source = ../common/space.jpg;
}
