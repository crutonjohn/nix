{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      redhat.vscode-yaml
      ms-vscode-remote.remote-ssh
    ];
    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font Mono";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "workbench.colorTheme" = "Solarized Dark";
      "explorer.confirmDragAndDrop" = false;
    };
  };
}
