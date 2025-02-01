{ pkgs, ... }:

{

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      waveform
      obs-ndi
      wlrobs
      obs-teleport
    ];
  };

}
