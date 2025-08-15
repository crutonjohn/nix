{ ... }:

{
    imports = [
    ./programs
    ./scripts
    ];

    home = {
        username = "crutonjohn";
        homeDirectory = "/home/crutonjohn";
        stateVersion = "25.05";
    };
    programs.home-manager.enable = true;

}
