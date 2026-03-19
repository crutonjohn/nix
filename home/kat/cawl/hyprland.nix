{ pkgs, inputs, ... }:
{

  imports = [
    # shared configs
    ../../shared/hyprland
    # machine specific configs
    ./hyprland
  ];
}
