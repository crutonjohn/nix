{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "bjohn";
    userEmail = "bjohn@akamai.com";
  };
}

