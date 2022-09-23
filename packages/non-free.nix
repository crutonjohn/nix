{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "discord"
    "slack"
    "vscode"
    "vscode-extension-MS-python-vscode-pylance"
    "vscode-extension-ms-vsliveshare-vsliveshare"
  ];
}