{ pkgs, ... }:
{

  home.packages = with pkgs; [
    discord
    newrecruit-builder
    #newrecruit-editor
    teamspeak6-client
  ];

}
