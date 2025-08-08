{ pkgs, ... }:

{

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];

    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = {
      enable = true;
      enableRenice = true;
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        waveform
        obs-ndi
        wlrobs
        obs-teleport
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-qt
    (lutris.override {
      extraLibraries = pkgs: [];
      extraPkgs = pkgs: [];
    })
    bottles
    heroic
    teamspeak6-client
  ];


}
