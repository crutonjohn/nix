{ ... }: {

xdg.desktopEntries = {
  lychee-slicer = {
    name = "Lychee Slicer";
    genericName = "3D Printing Slicer";
    exec = "lychee-slicer %U";
    terminal = false;
    categories = [ "Application" "Printing" ];
  };
  pog = {
    name = "Pog Configurator";
    genericName = "KMK Keyboard Configuration GUI";
    exec = "pog %U";
    terminal = false;
    categories = [ "Utility" ];
  };
  zzsteam = {
    name = "Steam With VGUI";
    genericName = "Valve'Video Game Monopoly";
    exec = "steam -vgui";
    terminal = false;
    categories = [ "Games" ];
  };
};

}
