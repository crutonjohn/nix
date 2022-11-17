{ config, lib, pkgs, outputs, ... }:
{
  imports = [
    ../common/generic.nix
    ./git.nix
  ];

  home.username = "bjohn";
  home.homeDirectory = "/home/bjohn";


  home.packages = with pkgs; [
    i3status-rust
    networkmanager_dmenu
    comma
    feh
    rofi
    polybar
    powertop
    volctl
    zeal
    xss-lock
    psmisc
    zlib
    dmenu
    arandr
    picom
    scrot
    imagemagick

    (pkgs.writeScriptBin "i3loadlayout" ''
    #!/usr/bin/env bash
    # workspace 1
    i3-msg "workspace admin; append_layout ~/.config/i3/ws1.json"
    (alacritty &)
    i3-msg "workspace code; append_layout ~/.config/i3/ws2.json"
    (vscodium > /dev/null 2>&1 &)
    (firefox > /dev/null 2>&1 &)
    i3-msg "workspace irc; append_layout ~/.config/i3/ws3.json"
    (discord > /dev/null 2>&1 &)
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
    /opt/Webex/bin/CiscoCollabHost /opt/Webex/lib/ libWebexAppLoader.so /Start &
    '')
  ];

  home.file.".xsessionrc".text = ''
    export PATH=$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/.local/bin:$PATH
    xset r rate 200 50
    '';
  home.file.".Xresources".text = ''
    Xcursor.theme: Adwaita
    Xcursor.size: 32
    Xft.dpi: 144
    Xft.autohint: 0
    Xft.lcdfilter:  lcddefault
    Xft.hintstyle:  hintfull
    Xft.hinting: 1
    Xft.antialias: 1
    Xft.rgba: rgb
    '';

  home.sessionVariables.LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  home.sessionVariables.LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  #Desktop Experience
  home.file.".config/i3/config".source = ./i3/i3.conf;
  home.file.".config/i3/ws1.json".source = ./i3/layout/ws1.json;
  home.file.".config/i3/ws2.json".source = ./i3/layout/ws2.json;
  home.file.".config/i3/ws3.json".source = ./i3/layout/ws3.json;
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
        font: "JetBrainsMono Nerd Font 14";
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
        format = "<b>%s</b>\n%b";
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
