{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "crutonjohn@pm.me";
    userName = "Curtis John";
    includes = [
      {
        path = "~/.config/git/gitconfig-personal";
      }
    ];
  };

}
