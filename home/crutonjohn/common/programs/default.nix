{ pkgs, inputs, ... }: {

  imports = [
    ./firefox.nix
    ./floorp.nix
    ./git.nix
    ./shell.nix
    ./vim.nix
    ./vscode.nix
    ./zsh/zsh.nix
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      awscli2
      alacritty
      asciinema
      bitwarden
      bitwarden-cli
      cachix
      containerd
      cz-cli
      dig
      fish
      file
      ffmpegthumbnailer
      ffmpeg
      gawk
      go
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
      #obsidian
      minikube
      dyff
      traceroute
      kns
      pkgs.unstable.fluxcd
      pkgs.unstable.zed-editor
    ];
  };


}
