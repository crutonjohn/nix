{ ... }:

{
  imports = [
    ./programs
    ./scripts
  ];

  home = {
    username = "crutonjohn";
    homeDirectory = "/home/crutonjohn";
    stateVersion = "25.11";
  };
  programs.home-manager.enable = true;

}
