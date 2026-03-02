{ ... }:

{
  imports = [
    ./programs
    ./scripts
  ];

  home = {
    username = "kat";
    homeDirectory = "/home/kat";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;

}
