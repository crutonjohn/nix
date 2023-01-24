{ pkgs, inputs, ...}:
{

  # Unfree/Tax
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    signal-desktop
    steam
  ];
}
