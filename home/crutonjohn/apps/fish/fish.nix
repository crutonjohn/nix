{ config, lib, pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
    };
    functions = {
    };
  };
  programs.fzf.enableFishIntegration = true;

}
