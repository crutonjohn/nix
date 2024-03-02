{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "crutonjohn@pm.me";
  };
}
