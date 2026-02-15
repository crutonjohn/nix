{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.teamspeak6-server;
in
{
  options.services.teamspeak6-server = {
    enable = mkEnableOption "TeamSpeak 6 Server (Beta)";

    package = mkOption {
      type = types.package;
      default = pkgs.teamspeak6-server;
      defaultText = literalExpression "pkgs.teamspeak6-server";
      description = "The teamspeak6-server package to use.";
    };

    environmentFile = mkOption {
      type = types.path;
      example = "/run/secrets/teamspeak6-server.env";
      description = ''
        Environment file to load containing configuration.
        Reference: https://github.com/teamspeak/teamspeak6-server/blob/main/CONFIG.md

        Required variables:
        TSSERVER_LICENSE_ACCEPTED
        TSSERVER_DATABASE_PLUGIN

        Optional variables:
        TSSERVER_LICENSE_PATH  (default: "")
        TSSERVER_CONFIG_FILE   (default: "")
        TSSERVER_DEFAULT_PORT  (default: 9987)
        TSSERVER_FILE_TRANSFER_PORT  (default: 30033)
        TSSERVER_DATABASE_PLUGIN (mariadb / sqlite)
        TSSERVER_DATABASE_HOST ()
        TSSERVER_DATABASE_PORT ()
        TSSERVER_DATABASE_NAME ()
        TSSERVER_DATABASE_USERNAME ()
        TSSERVER_DATABASE_PASSWORD ()
        TSSERVER_DATABASE_CONNECTIONS (default: 10)
        TSSERVER_DATABASE_SQL_CREATE_PATH ()
        TSSERVER_QUERY_HTTP_ENABLED ()
        TSSERVER_QUERY_HTTP_PORT (default: 10080)
        TSSERVER_QUERY_SSH_ENABLED ()
        TSSERVER_QUERY_SSH_PORT (default: 10022)
        TSSERVER_QUERY_ADMIN_PASSWORD ()
        TSSERVER_QUERY_ALLOW_LIST ()
        TSSERVER_QUERY_DENY_LIST ()
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.teamspeak6-server = {
      description = "TeamSpeak 6 Server (Beta)";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        DynamicUser = true;
        EnvironmentFile = cfg.environmentFile;
        ExecStart = "${cfg.package}/bin/tsserver";

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
