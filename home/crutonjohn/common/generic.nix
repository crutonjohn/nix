{ config, pkgs, nixpkgs, lib, inputs, ... }: {
  imports = [
    ../apps/fish/fish.nix
    ../apps/vim/vim.nix
    ../apps/vscode.nix
    ./firefox.nix
  ];
  programs.home-manager.enable = true;

  home = {
    stateVersion = "22.11";
    packages = with pkgs; [
      (python310.withPackages (ps: with ps; [ pip ansible ]))
      awscli2
      alacritty
      bitwarden
      bitwarden-cli
      cachix
      containerd
      cz-cli
      dig
      file
      fluxcd
      ffmpeg
      gawk
      go
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
      #obsidian
      minikube
      dyff
      traceroute
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; };
  };
  programs.fzf.enable = true;
  programs.eza = {
    enable = true;
    enableAliases = true;
  };
  programs.bat = {
    enable = true;
    config.theme = "ansi-dark";
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    newSession = true;
    shortcut = "a";
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    tmuxp.enable = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 10;
        normal.family = "FiraCode Nerd Font Mono";
        normal.style = "Regular";
        bold.family = "FiraCode Nerd Font Mono";
        bold.style = "Bold";
        italic.family = "FiraCode Nerd Font Mono";
        italic.style = "Italic";
        bold_italic.family = "FiraCode Nerd Font Mono";
        bold_italic.style = "Bold Italic";
      };
      window.opacity = 0.9;
      colors = {
        primary.background = "0x1a1b26";
        primary.foreground = "0xa9b1d6";
        normal = {
          black = "0x32344a";
          red = "0xf7768e";
          green = "0x9ece6a";
          yellow = "0xe0af68";
          blue = "0x7aa2f7";
          magenta = "0xad8ee6";
          cyan = "0x449dab";
          white = "0x787c99";
        };
        bright = {
          black = "0x444b6a";
          red = "0xff7a93";
          green = "0xb9f27c";
          yellow = "0xff9e64";
          blue = "0x7da6ff";
          magenta = "0xbb9af7";
          cyan = "0x0db9d7";
          white = "0xacb0d0";
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$nix_shell"
        "$kubernetes"
        "$aws"
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];
      scan_timeout = 10;
      battery.display = [{
        threshold = 15; # display battery information if charge is <= 15%
      }];
      nix_shell = {
        symbol = "nix";
        format = "[<$symbol> ]($style)";
        style = "blue bold";
        disabled = false;
      };
      git_branch = {
        format = "[$symbol$branch(:$remote_branch)](fg:76)";
        symbol = "⎇ ";
        disabled = false;
      };
      directory = {
        style = "bold fg:39";
        truncation_symbol = "//.../";
        truncate_to_repo = true;
        # repo_root_style = "bold yellow";
      };
      aws = {
        format = "$symbol[$profile( $region)]($style)";
        style = "bold yellow";
        symbol = "☁️ ";
        disabled = false;
      };
      aws.region_aliases = {
        af-south-1 = "Cape Town";
        ap-east-1 = "Hong Kong";
        ap-northeast-1 = "Tokyo";
        ap-northeast-2 = "Seoul";
        ap-northeast-3 = "Osaka";
        ap-south-1 = "Mumbai";
        ap-southeast-1 = "Singapore";
        ap-southeast-2 = "Sydney";
        ca-central-1 = "Canada";
        eu-central-1 = "Frankfurt";
        eu-north-1 = "Stockholm";
        eu-south-1 = "Milan";
        eu-west-1 = "Ireland";
        eu-west-2 = "London";
        eu-west-3 = "Paris";
        me-south-1 = "Bahrain";
        sa-east-1 = "São Paulo";
        us-east-1 = "N. Virginia";
        us-east-2 = "Ohio";
        us-west-1 = "N. California";
        us-west-2 = "Oregon";
      };
      username = {
        style_root = "bold red";
        style_user = "cyan bold";
        show_always = true;
        disabled = false;
      };
      kubernetes = { disabled = false; };
    };
  };
}

