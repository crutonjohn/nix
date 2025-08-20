{ lib, pkgs, ... }: {

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      log = { enabled = false; };
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
        linemode = "mtime";
        show_symlink = true;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv = { enable = true; };
  };

  programs.eza = { enable = true; };

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

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$username"
        "$hostname"
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
        format = "[$user]($style) ";
      };
      hostname = {
        ssh_only = true;
        ssh_symbol = "";
        format = "[$ssh_symbol](cyan bold) @ [$hostname](green bold) ";
        detect_env_vars = [ "!TMUX" "SSH_CONNECTION" ];
        disabled = false;
      };
      kubernetes = { disabled = false; };
    };
  };

}
