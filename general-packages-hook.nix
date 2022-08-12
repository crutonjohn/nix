{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./de/i3-gaps.nix
      ./de/i3status-rust.nix
      ./de/lightdm.nix
      ./de/rofi.nix
      ./term/alacritty.nix
    ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    firefox
    curl
    bitwarden-cli
    chezmoi
    fish
    exa
    kubectl
    krew
  ];

}
