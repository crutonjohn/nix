{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "crutonjohn";
    userEmail = "crutonjohn@pm.me";
  };
}