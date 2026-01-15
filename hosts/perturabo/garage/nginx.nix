{ config, ... }:

{

  security.acme.certs = {
    "s3.garage.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      extraLegoFlags = [ ];
      group = "nginx";
      extraDomainNames = [
        "volsync.s3.garage.heyjohn.family"
        "volsync.web.garage.heyjohn.family"
        "web.garage.heyjohn.family"
        "admin.garage.heyjohn.family"
        "ui.garage.heyjohn.family"
      ];
    };
  };

  systemd.timers = {
    "custom-acme-s3.garage.heyjohn.family" = {
      description = "Hack to renew ACME Certificate every day";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 22:00:00";
        Persistent = "yes";
        AccuracySec = "600s";
        Unit = "acme-order-renew-s3.garage.heyjohn.family.service";
      };
    };
  };

  services.nginx.virtualHosts = {
    "volsync.web.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
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
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "web.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
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
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "admin.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
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
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "ui.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
      forceSSL = true;
      listenAddresses = [ "192.168.130.4" ];
      locations = {
        "/" = {
          proxyPass = "http://192.168.130.4:3919";
          proxyWebsockets = true;
          recommendedProxySettings = true;
        };
      };
      extraConfig = ''
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "volsync.s3.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
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
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
    "s3.garage.heyjohn.family" = {
      useACMEHost = "s3.garage.heyjohn.family";
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
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_connect_timeout 300;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
      '';
    };
  };

}
