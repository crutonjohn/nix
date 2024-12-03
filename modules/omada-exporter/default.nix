{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.omada-exporter;
in {
  options.services.omada-exporter = {
    enable = mkEnableOption "Omada Controller Prometheus Exporter";
    
    package = mkOption {
      type = types.package;
      default = pkgs.omada-exporter;
      defaultText = literalExpression "pkgs.omada-exporter";
      description = "The omada-exporter package to use.";
    };

    environmentFile = mkOption {
      type = types.path;
      example = "/run/secrets/omada-exporter.env";
      description = ''
        Environment file to load containing configuration.
        Required variables: OMADA_HOST, OMADA_USER, OMADA_PASS

        Optional variables:
        OMADA_PORT              (default: 9202)
        OMADA_SITE             (default: Default)
        LOG_LEVEL              (default: error)
        OMADA_REQUEST_TIMEOUT  (default: 15)
        OMADA_INSECURE        (default: false)
        OMADA_DISABLE_GO_COLLECTOR      (default: true)
        OMADA_DISABLE_PROCESS_COLLECTOR (default: true)
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.omada-exporter = {
      description = "Omada Controller Prometheus Exporter";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        DynamicUser = true;
        EnvironmentFile = cfg.environmentFile;
        ExecStart = "${cfg.package}/bin/omada_exporter";

        # Security hardening
        ProtectSystem = "strict";
        ProtectHome = true;
        NoNewPrivileges = true;
        RestrictNamespaces = true;
        RestrictRealtime = true;
        PrivateTmp = true;
        ProtectHostname = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectControlGroups = true;
        MemoryDenyWriteExecute = true;
      };
    };
  };
}