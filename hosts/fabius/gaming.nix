{ pkgs, inputs, ... }:

{

  imports = [ inputs.play-nix.nixosModules.play ];

  play = {
    amd.enable = true; # AMD GPU optimization
    steam.enable = true; # Steam with Proton-CachyOS
    lutris.enable = true; # Lutris game manager
    gamemode.enable = true; # Performance optimization
    ananicy.enable = true; # Process scheduling
  };

  programs = {
    # steam = {
    #   enable = true;
    #   remotePlay.openFirewall = true;
    #   dedicatedServer.openFirewall = true;
    #   localNetworkGameTransfers.openFirewall = true;
    #   gamescopeSession.enable = true;
    #   extraCompatPackages = with pkgs; [ proton-ge-bin ];

    # };
    # gamescope = {
    #   enable = true;
    #   capSysNice = false;
    # };
    # gamemode = {
    #   enable = true;
    #   enableRenice = true;
    # };

    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        waveform
        # distroav
        obs-vaapi
        obs-pipewire-audio-capture
        wlrobs
        obs-teleport
        # https://github.com/nowrep/obs-vkcapture
        obs-vkcapture
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    mangohud
    # protonup-qt
    # (lutris.override {
    #   extraLibraries = pkgs: [ ];
    #   extraPkgs = pkgs: [ ];
    # })
    bottles
    # heroic
    teamspeak6-client
    sdl3
    sdl3-ttf
    sdl3-image
  ];

  services.sunshine = {
    package = pkgs.unstable.sunshine;
    enable = true;
    autoStart = true;
    openFirewall = true;
    capSysAdmin = true;
    applications = {
      apps = [
        {
          name = "Steam Big Picture";
          detached = [
            "sudo -u crutonjohn setsid steam steam://open/bigpicture"
          ];
          prep-cmd = [
            {
              do = ''
                sh -c "hyprctl keyword monitor HEADLESS-2,$${SUNSHINE_CLIENT_WIDTH}x$${SUNSHINE_CLIENT_HEIGHT}@$${SUNSHINE_CLIENT_FPS},auto,1 &&
                hyprctl keyword monitor DP-1,disable &&
                hyprctl keyword monitor DP-2,disable &&
                sudo -u crutonjohn setsid steam steam://close/bigpicture"
              '';
              undo = ''
                sh -c "sudo -u crutonjohn setsid steam steam://close/bigpicture &&
                hyprctl keyword monitor HEADLESS-2,disable &&
                hyprctl reload"
              '';
            }
          ];
          # exclude-global-prep-cmd = "false";
          # auto-detach = "true";
        }
      ];
    };
  };

}
