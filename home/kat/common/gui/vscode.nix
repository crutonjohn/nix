{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        redhat.vscode-yaml
        ms-vscode-remote.remote-ssh
      ];
      userSettings = {
        "editor.fontFamily" = "0xProto Nerd Font Mono";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "workbench.colorTheme" = "Solarized Dark";
        "explorer.confirmDragAndDrop" = false;
        "workbench.startupEditor" = "none";
      };
    };
  };
}
