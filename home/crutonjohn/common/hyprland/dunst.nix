{ pkgs, ... }: {

  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        width = 300;
        height = 100;
        offset = "5x30";
        follow = "keyboard";
        transparency = 50;
        frame_color = "#ffc0cb";
        font = "0xProto Nerd Font Mono";
        padding = 8;
        horizontal_padding = 8;
        frame_width = 1;
        line_height = 4;
        format = ''
          <b>%s</b>
          %b'';
        show_age_threshold = 30;
        separator_height = 2;
        separator_color = "frame";
        markup = "full";
        ignore_newline = "no";
        word_wrap = "yes";
        alignment = "right";
        origin = "bottom-right";
        gap_size = 2;
        stack_duplicates = true;
        corner_radius = 5;
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#d9e0ee";
        timeout = 10;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#d9e0ee";
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
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

  };

}
