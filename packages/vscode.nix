{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    ];
    userSettings = {
      "editor.fontFamily" = "Iosevka";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 13;
      "workbench.colorTheme" = "Solarized Dark";
    };
  };
 }
