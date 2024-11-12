{ pkgs, inputs, ... }: {

# home.pointerCursor = {
#   package = "inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default";
#   name = "rose-pine-hyprcursor";
#   size = 24;
#   gtk.enable = true;
#   x11.enable = true;
# };

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

# home.packages = with pkgs; [
#   apple-cursor
# ];

qt = {
  enable = true;
  # platformTheme.name = "gtk";
};

}
