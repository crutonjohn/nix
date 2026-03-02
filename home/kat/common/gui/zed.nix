{ ... }: {
  programs.zed-editor = {
    enable = true;
    #package = pkgs.vscode;
    # themes = { "Ayu Dark" };
    installRemoteServer = true;
    userSettings = {
      "tab_size" = 2;
      "agent" = {
        "model_parameters" = [ ];
        "default_model" = {
          "provider" = "ollama";
          "model" = "codegemma:7b";
        };
        "version" = "2";
      };
      "theme" = "Ayu Dark";
      "ui_font_size" = 16;
      "buffer_font_size" = 16;
      "buffer_font_family" = "0xProto Nerd Font Mono";
      "language_models" = {
        "ollama" = {
          "api_url" = "http://192.168.142.17:11434";
          "low_speed_timeout_in_seconds" = 120;
          "available_models" = [
            {
              "provider" = "ollama";
              "name" = "qwen2.5-coder:14b";
              "display_name" = "Qwen Coder";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
            {
              "provider" = "ollama";
              "name" = "codegemma:7b";
              "display_name" = "Code Gemma";
              "max_tokens" = 33000;
              "keep_alive" = "10m";
            }
          ];
        };
      };
      "languages" = {
        "Nix" = {
          "language_servers" = [ "nil" "!nixd" ];
          "tab_size" = 2;
          "formatter" = {
            "external" = {
              "command" = "nixfmt";
              "arguments" = [ "--quiet" "--" ];
            };
          };
        };
      };
      "lsp" = {
        "nil" = {
          "initialization_options" = {
            "formatting" = { "command" = [ "nixfmt" ]; };
          };
        };
      };
    };
    extensions = [ "nix" "latex" "make" "tmux" "toml" ];
  };
}
