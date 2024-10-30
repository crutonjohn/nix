{ config, pkgs, ... }: {

  programs.git = {
    enable = true;
    userName = "Buck John";
    userEmail = "bjohn@akamai.com";
    includes = [
      {
        path = "~/.config/git/gitconfig-work";
        condition = "gitdir:~/Documents/Projects/";
      }
      {
        path = "~/.config/git/gitconfig-personal";
        condition = "gitdir:~/Documents/nix/";
      }
    ];
  };
}

