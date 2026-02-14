{ pkgs, ... }:

{

  programs.steam.enable = true;

  # programs.obs-studio = {
  #   enable = true;
  #   plugins = with pkgs.obs-studio-plugins; [
  #     waveform
  #     distroav
  #     wlrobs
  #     obs-teleport
  #   ];
  # };

}
