{ config, lib, pkgs, ... }: {
  programs.fish = {
    enable = true;
    functions = {
    };
  };
  programs.fzf.enableFishIntegration = true;

}
