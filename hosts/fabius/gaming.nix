{ pkgs, ... }:

{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

  };
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [mangohud protonup-qt lutris bottles heroic];

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
