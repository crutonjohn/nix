{ config, pkgs, nixpkgs, lib, inputs, ... }:
{
  imports =
    [
      ../apps/zsh/zsh.nix
      ../apps/vim/vim.nix
      ../apps/vscode.nix
    ];
  home = {
    stateVersion = "22.05";
    packages = with pkgs; [
      ( python310.withPackages (ps: with ps; [ pip poetry ansible ]) )
      awscli2
      alacritty
      bitwarden
      bitwarden-cli
      cachix
      chezmoi
      containerd
      commitizen
      cz-cli
      dig
      file
      fluxcd
      ffmpeg
      gawk
      go-chromecast
      home-manager
      htop
      jq
      jsonnet
      k9s
      krew
      kubectl
      kubernetes-helm
      kubecolor
      kubectx
      kustomize
      kustomize-sops
      lazydocker
      mlocate
      nix-index
      nixfmt
      openssl
      p7zip
      pre-commit
      rclone
      ripgrep
      screen
      sops
      sqlite
      terraform
      tree
      unzip
      vlc
      watchexec
      whois
      wget
      obsidian
      discord
      minikube
    ];
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      settings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "about:blank";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;
        "media.av1.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
        "signon.rememberSignons" = false;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      onepassword-password-manager
      bitwarden
      ublock-origin
      darkreader
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv = {
      enable = true;
    };
  };
  programs.fzf.enable = true;
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
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

