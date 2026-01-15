{ config, ... }:

{

  security.acme.certs = {
    "volsync.s3.garage.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
    };
    "volsync.web.garage.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
    };
    "admin.garage.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
    };
  };

  systemd.timers = {
    "custom-acme-volsync.s3.garage.heyjohn.family" = {
      description = "Hack to renew ACME Certificate every day";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 22:00:00";
        Persistent = "yes";
        AccuracySec = "600s";
        Unit = "acme-volsync.s3.garage.heyjohn.family.service";
      };
    };

    "custom-acme-volsync.web.garage.heyjohn.family" = {
      description = "Hack to renew ACME Certificate every day";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 22:00:00";
        Persistent = "yes";
        AccuracySec = "600s";
        Unit = "acme-volsync.web.garage.heyjohn.family.service";
      };
    };

    "custom-acme-admin.garage.heyjohn.family" = {
      description = "Hack to renew ACME Certificate every day";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 22:00:00";
        Persistent = "yes";
        AccuracySec = "600s";
        Unit = "acme-admin.garage.heyjohn.family.service";
      };
    };
  };

  services.nginx.virtualHosts = {
    "volsync.web.garage.heyjohn.family" = {
      useACMEHost = "volsync.web.garage.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://${config.services.garage.settings.s3_web.bind_addr}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      extraConfig = ''
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "admin.garage.heyjohn.family" = {
      useACMEHost = "admin.garage.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://${config.services.garage.settings.admin.api_bind_addr}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      extraConfig = ''
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "volsync.s3.garage.heyjohn.family" = {
      useACMEHost = "volsync.s3.garage.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://${config.services.garage.settings.s3_api.api_bind_addr}";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
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
