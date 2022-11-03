{ pkgs, ... }:
let
  lockscreen = pkgs.writeScriptBin "lockscreen" (builtins.readFile ./scripts/i3/lock.sh);
  loadlayout = pkgs.writeScriptBin "loadlayout" (builtins.readFile ./scripts/i3/load_layout.sh);
  launchpolybar = pkgs.writeScriptBin "launchpolybar" (builtins.readFile ./scripts/polybar/launch.sh);
in
{
  environment.systemPackages = [
    lockscreen
    loadlayout
    launchpolybar
  ];
}