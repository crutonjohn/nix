{ pkgs, inputs, ... }: {

  imports =
    [ ./fish ./zsh ./git.nix ./k9s.nix ./session.nix ./shell.nix ./vim.nix ];

  home = {
    packages = with pkgs; [
      awscli2
      asciinema
      bitwarden-cli
      cachix
      containerd
      cz-cli
      dig
      figlet
      fish
      file
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
      socat
      sops
      sqlite
      terraform
      tree
      unzip
      watchexec
      whois
      wget
      minikube
      dyff
      traceroute
      kns
      p7zip
      rar
      pkgs.unstable.fluxcd
      appimage-run
      at-spi2-atk
      brightnessctl
      catimg
      catt
      ceph
      colmena
      comma
      docker
      docker-compose
      gettext
      hexchat
      inputs.compose2nix.packages.x86_64-linux.default
      jdk11
      lapce
      libgcc
      libinput
      libnotify
      neofetch
      networkmanager
      nfs-utils
      # nil -- installed via flake
      inputs.nil.packages.x86_64-linux.default
      nixd
      nmap
      pixman
      powertop
      psmisc
      qemu
      step-cli
      tailscale
      termshark
      tlp
      unixtools.procps
      wev
    ];
  };

}
