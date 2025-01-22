{ pkgs, inputs, ... }: {

  imports = [
    # ./firefox.nix
    ./floorp.nix
    ./git.nix
    ./shell.nix
    ./vim.nix
    ./vscode.nix
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "24.11";
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
      figlet
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
      p7zip
      rar
      pkgs.unstable.fluxcd
      pkgs.unstable.zed-editor
    ];
  };


}
