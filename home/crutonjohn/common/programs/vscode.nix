{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      redhat.vscode-yaml
      ms-vscode-remote.remote-ssh
    ];
    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 16;
      "workbench.colorTheme" = "Solarized Dark";
      "explorer.confirmDragAndDrop" = false;
      "workbench.startupEditor" = "none";
    };
  };
}
