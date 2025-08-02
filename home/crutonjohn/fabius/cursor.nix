{ pkgs, inputs, ... }: {


gtk = {
  enable = true;
  theme = {
    # package = pkgs.gnome.gnome-themes-extra;
    name = "rose-pine-hyprcursor";
  };
};

home.sessionVariables = {
  HYPRCURSOR_SIZE = "24";
  HYPRCURSOR_THEME = "rose-pine-hyprcursor";
  XCURSOR_THEME = "rose-pine-hyprcursor";
  XCURSOR_SIZE = "24";
};

qt = {
  enable = true;
  # platformTheme.name = "gtk";
};

}
