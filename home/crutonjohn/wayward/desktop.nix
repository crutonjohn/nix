{ ... }:
{

  xdg.desktopEntries = {
    lychee-slicer = {
      name = "Lychee Slicer";
      genericName = "3D Printing Slicer";
      exec = "lychee-slicer %U";
      terminal = false;
      categories = [
        "Application"
        "Printing"
      ];
    };
    pog = {
      name = "Pog Configurator";
      genericName = "KMK Keyboard Configuration GUI";
      exec = "pog %U";
      terminal = false;
      categories = [ "Utility" ];
    };
    newrecruit-builder = {
      name = "New Recruit - Builder";
      genericName = "Builder";
      exec = "newrecruit-builder %U";
      terminal = false;
      categories = [ "Utility" ];
    };
    anytype = {
      name = "teamspeak";
      genericName = "teamspeak";
      exec = "TeamSpeak %U";
      terminal = false;
      categories = [ "Application" ];
    };
  };

}
