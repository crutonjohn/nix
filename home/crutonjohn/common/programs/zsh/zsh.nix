{ config, lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    initExtraBeforeCompInit = builtins.readFile ./zshrc;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "tmuxinator" "nix-shell" "direnv" ];
    };
  };
  programs.fzf.enableZshIntegration = true;

}
