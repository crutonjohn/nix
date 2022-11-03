{ config, pkgs, nixpkgs, lib, ... }:
{
  imports =
    [
      ../apps/zsh/zsh.nix
      ../apps/vim/vim.nix
      ../apps/git.nix
      ../apps/vscode.nix
    ];
  home = {
    stateVersion = "22.05";
    packages = with pkgs; [
      ( python310.withPackages (ps: with ps; [ pip poetry ansible ]) )
      alacritty
      bitwarden
      bitwarden-cli
      cachix
      chezmoi
      containerd
      cz-cli
      dig
      exa
      file
      fluxctl
      gawk
      htop
      jq
      jsonnet
      k9s
      kubectl
      kubecolor
      kubectx
      kustomize
      kustomize-sops
      lazydocker
      nix-index
      nixfmt
      openssl
      p7zip
      ripgrep
      sops
      sqlite
      terraform
      tree
      unzip
      watchexec
      whois
      obsidian 
      discord
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.fzf.enable = true;
  programs.bat = {
    enable = true;
    config.theme = "ansi-dark";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/starship.toml".source = ../apps/starship.toml;

  xdg.configFile."alacritty/alacritty.yml".source = ../apps/alacritty.yml;
  xdg.configFile."oh-my-zsh/plugins/nix-shell".source = pkgs.fetchFromGitHub {
    owner = "chisui";
    repo = "zsh-nix-shell";
    rev = "f8574f27e1d7772629c9509b2116d504798fe30a";
    sha256 = "0svskd09vvbzqk2ziw6iaz1md25xrva6s6dhjfb471nqb13brmjq";
  };
}

