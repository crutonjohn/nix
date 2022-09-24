{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
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
