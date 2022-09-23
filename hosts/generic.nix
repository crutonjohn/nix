{ config, pkgs, nixpkgs, lib, ... }:
{
  imports =
    [
      ../programs/zsh/zsh.nix
      ../programs/vim/vim.nix
      ../programs/git.nix
      ../programs/vscode.nix
    ];

  home = {
    stateVersion = "22.05";
    packages = with pkgs; [
      ( python310.withPackages (ps: with ps; [ pip poetry ansible ]) )
      bitwarden
      bitwarden-cli
      cachix
      chezmoi
      containerd
      cz-cli
      dig
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
      pstree
      ripgrep
      sops
      sqlite
      terraform
      tree
      unzip
      watchexec
      whois
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

  xdg.configFile."alacritty/alacritty.yml".source = ../packages/alacritty.yml;
  xdg.configFile."oh-my-zsh/plugins/nix-shell".source = pkgs.fetchFromGitHub {
    owner = "chisui";
    repo = "zsh-nix-shell";
    rev = "f8574f27e1d7772629c9509b2116d504798fe30a";
    sha256 = "0svskd09vvbzqk2ziw6iaz1md25xrva6s6dhjfb471nqb13brmjq";
  };
}

