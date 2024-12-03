{ config, ... }:

{

  services.nginx.virtualHosts = {
    "minio-backup.heyjohn.family" = {
      enableACME = false;
      forceSSL = false;
      listen = [
        {
          addr = "192.168.128.5";
          port = 9001;
        }
      ];
      listenAddresses = [
        "192.168.128.5"
      ];
      locations."/" = {
        proxyPass = "http://${config.services.minio.consoleAddress}";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
      extraConfig =
        ''
        proxy_connect_timeout 300;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        chunked_transfer_encoding off;
        proxy_request_buffering off;
        ignore_invalid_headers off;
        '';
    };
    "s3-backup.heyjohn.family" = {
      enableACME = false;
      forceSSL = false;
      listen = [
        {
          addr = "192.168.128.5";
          port = 9000;
        }
      ];
      listenAddresses = [
        "192.168.128.5"
      ];
      locations."/" = {
        proxyPass = "http://${config.services.minio.listenAddress}";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
    };
  };

}
