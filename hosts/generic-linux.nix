{ pkgs, ...}:
{
  # imports = [ ../packages/tmux/tmux.nix ];
  programs.home-manager.enable = true;
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
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
  };

  # Blueman
  services.blueman-applet.enable = true;

  home.packages = with pkgs; [
    i3status-rust
    i3
    comma
    feh
    networkmanager
    rofi
    polybar
    powertop
    volctl
    zeal
  ];
  
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "media.av1.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      # onepassword-password-manager
      bitwarden
      ublock-origin
      darkreader
    ];
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
  
  #i3wm
  home.file.".config/i3/conf".source = ../packages/i3/i3.conf;
  home.file.".config/i3/load_layout.sh".source = ../packages/i3/load_layout.sh;
  home.file.".config/i3/ws1.json".source = ../packages/i3/ws1.json;
  home.file.".config/i3/ws2.json".source = ../packages/i3/ws2.json;
  home.file.".config/i3/ws3.json".source = ../packages/i3/ws3.json;
  home.file.".config/picom.conf".source = ../packages/picom/picom.conf;
  home.file.".config/rofi/config.rasi".source = ../packages/rofi/config.rasi;
  home.file.".config/polybar/config".source = ../packages/polybar/config;
  home.file.".config/polybar/launch.sh".source = ../packages/polybar/launch.sh;
}