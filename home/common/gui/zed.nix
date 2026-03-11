{ ... }:
{
  programs.zed-editor = {
    enable = true;
    installRemoteServer = true;
    userSettings = {
      "tab_size" = 2;
      "agent" = {
        "model_parameters" = [ ];
        "default_model" = {
        };
        "version" = "2";
      };
      "theme" = "Ayu Dark";
      "ui_font_size" = 16;
      "buffer_font_size" = 16;
      "buffer_font_family" = "0xProto Nerd Font Mono";
      "language_models" = {
      };
      "languages" = {
        "Nix" = {
          "language_servers" = [
            "nil"
            "!nixd"
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
        "nil" = {
          "initialization_options" = {
            "formatting" = {
              "command" = [ "nixfmt" ];
            };
          };
        };
      };
    };
    extensions = [
      "nix"
      "latex"
      "make"
      "tmux"
      "toml"
      "yaml"
    ];
  };
}
