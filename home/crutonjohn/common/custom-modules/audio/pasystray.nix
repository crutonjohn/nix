{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    services.pasystray-custom = {
      enable = mkEnableOption "PulseAudio system tray";
    };
  };

  config = mkIf config.services.pasystray-custom.enable {
    systemd.user.services.pasystray = {
      Unit = {
        Description = "PulseAudio system tray";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };

      Service = {
        Environment =
          let toolPaths = makeBinPath [ pkgs.paprefs pkgs.pavucontrol ];
          in [ "PATH=${toolPaths}" ];
        ExecStart = "${pkgs.pasystray}/bin/pasystray";
      };
    };
  };
}
