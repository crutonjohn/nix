{ pkgs, ... }:
{

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-B";
      package = pkgs.tokyonight-gtk-theme;
    };
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    cursorTheme = {
      package = pkgs.rose-pine-hyprcursor;
      name = "rose-pine-hyprcursor";
      size = 20;

    };
  };

  home.sessionVariables = {
    HYPRCURSOR_SIZE = "20";
    HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    XCURSOR_THEME = "rose-pine-hyprcursor";
    XCURSOR_SIZE = "20";
    GTK_THEME = "Tokyonight-Dark-B";
  };

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
  };

}
