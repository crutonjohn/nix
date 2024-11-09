{ pkgs, ... }: {

home.pointerCursor = {
  package = pkgs.libsForQt5.breeze-qt5;
  name = "Breeze Dark";
  size = 24;
  gtk.enable = true;
  x11.enable = true;
};

home.sessionVariables = {
  XCURSOR_THEME = "Breeze Dark";
  XCURSOR_SIZE = "24";
};

qt = {
  enable = true;
  platformTheme.name = "gtk";
};

}