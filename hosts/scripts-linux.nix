{ pkgs, ... }:
let
  lockscreen = pkgs.writeScriptBin "lockscreen" (builtins.readFile ../packages/i3/lock.sh);
  loadlayout = pkgs.writeScriptBin "loadlayout" (builtins.readFile ../packages/i3/load_layout.sh);
  launchpolybar = pkgs.writeScriptBin "launchpolybar" (builtins.readFile ../packages/polybar/launch.sh);
in
{
  environment.systemPackages = [
    lockscreen
    loadlayout
    launchpolybar
  ];
}