{ config, ... }:

{

  security.acme.certs = {
    "minio-perturabo.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
    };
    "s3-perturabo.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
    };
  };

  systemd.timers."custom-acme-s3-perturabo.heyjohn.family" = {
    description = "Hack to renew ACME Certificate every day";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 22:00:00";
      Persistent = "yes";
      AccuracySec = "600s";
      Unit = "acme-s3-perturabo.heyjohn.family.service";
    };
  };

  systemd.timers."custom-acme-minio-perturabo.heyjohn.family" = {
    description = "Hack to renew ACME Certificate every day";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 22:00:00";
      Persistent = "yes";
      AccuracySec = "600s";
      Unit = "acme-minio-perturabo.heyjohn.family.service";
    };
  };

  services.nginx.virtualHosts = {
    "minio-perturabo.heyjohn.family" = {
      useACMEHost = "minio-perturabo.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://${config.services.minio.consoleAddress}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
        # "/.well-known/acme-challenge" = {
        #   root = "/var/lib/acme/acme-challenge";
        # };
      };
      extraConfig = ''
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "s3-perturabo.heyjohn.family" = {
      useACMEHost = "s3-perturabo.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://${config.services.minio.listenAddress}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
        # "/.well-known/acme-challenge" = {
        #   root = "/var/lib/acme/acme-challenge";
        # };
      };
      extraConfig = ''
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
  };

}
