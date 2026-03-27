{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    #package = pkgs.vscode;
    # themes = { "Ayu Dark" };
    # enableMcpIntegration = true;
    installRemoteServer = true;
    extensions = [
      "nix"
      "latex"
      "make"
      "tmux"
      "toml"
      "yaml"
      "helm"
      "kagimcp"
      "jq"
      "lua"
      "fish"
      "dockerfile"
      "docker-compose"
      "go-snippets"
      "gosum"
      "gotmpl"
      "rose-pine-theme"
    ];
    extraPackages = [
      pkgs.nixd
      pkgs.nixfmt
      pkgs.nixfmt-tree
    ];
    userSettings = {
      "tab_size" = 2;
      "agent" = {
        "model_parameters" = [ ];
        "default_model" = {
          "provider" = "ollama";
          "model" = "codegemma:7b";
        };
      };
      "telemetry" = {
        "metrics" = false;
      };
      "theme" = "Ayu Dark";
      "ui_font_size" = 16;
      "buffer_font_size" = 16;
      "buffer_font_family" = "0xProto Nerd Font Mono";
      "language_models" = {
        "ollama" = {
          "api_url" = "http://192.168.142.17:11434";
          "available_models" = [
            {
              "name" = "qwen2.5-coder:14b";
              "display_name" = "Qwen 2.5 Coder 14b";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
            {
              "name" = "codegemma:7b";
              "display_name" = "Code Gemma 7b";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
            {
              "name" = "qwen3.5:2b";
              "display_name" = "Qwen 2b";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
            {
              "name" = "qwen3.5:9b";
              "display_name" = "Qwen 9b";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
          ];
        };
      };
      "languages" = {
        "Nix" = {
          "language_servers" = [
            "!nil"
            "nixd"
          ];
          "tab_size" = 2;
          "formatter" = {
            "external" = {
              "command" = "nixfmt";
              "arguments" = [
                "--quiet"
                "--"
              ];
            };
          };
        };
      };
      "lsp" = {
        "nixd" = {
          "initialization_options" = {
            "nixpkgs" = {
              "expr" = "import <nixpkgs> { }";
            };
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options";
              };
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []";
              };
              "play" = {
                "expr" = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options.play []";
              };
            };
            "diagnostic" = {
              "suppress" = [
              ];
            };
          };
        };
      };
    };
    userTasks = [
      {
        label = "Format Nix";
        command = "nix";
        args = [
          "nixfmt-tree"
          "$ZED_WORKTREE_ROOT"
        ];
      }
    ];
  };
}
