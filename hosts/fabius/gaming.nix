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

  hardware.display = {
    edid.enable = true;
    edid.packages = [
      (pkgs.runCommand "edid-custom" {} ''
        mkdir -p "$out/lib/firmware/edid"
        base64 -d > "$out/lib/firmware/edid/custom1.bin" <<'EOF'
        AP///////wBMLUBwAA4AAQEeAQOApV14Cqgzq1BFpScNSEi974BxT4HAgQCBgJUAqcCzANHACOgA
        MPJwWoCwWIoAUB10AAAeb8IAoKCgVVAwIDUAUB10AAAaAAAA/QAYeA//dwAKICAgICAgAAAA/ABT
        QU1TVU5HCiAgICAgAW4CA2fwXWEQHwQTBRQgISJdXl9gZWZiZD9AdXba28LDxMbHLAkHBxUHUFcH
        AGdUAIMBAADiAE/jBcMBbgMMAEAAmDwoAIABAgMEbdhdxAF4gFkCAADBNAvjBg0B5Q8B4PAf5QGL
        hJABb8IAoKCgVVAwIDUAUB10AAAaAAAAAAAAZw==
        EOF
      '')
    ];
    outputs.HDMI-A-1.edid = "edid/custom1.bin"
  };
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
            # "sudo -u crutonjohn setsid steam steam://open/bigpicture"
          ];
          prep-cmd = [
            {
              do = ''
                sh -c "sudo -u crutonjohn /home/crutonjohn/.local/bin/sunshine-start"
              '';
              undo = ''
                sh -c "sudo -u crutonjohn /home/crutonjohn/.local/bin/sunshine-stop"
              '';
            }
          ];
          output = "HDMI-1";
          # exclude-global-prep-cmd = "false";
          # auto-detach = "true";
        }
      ];
    };
  };

}
