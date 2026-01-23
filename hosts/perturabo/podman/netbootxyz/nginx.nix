{ ... }:

{

  services.nginx.virtualHosts = {
    # "_" = {
    #   # other settings in main nginx config
    #   # this is a shared virtual host
    #   rejectSSL = true;
    #   listenAddresses = [
    #     "192.168.130.4"
    #   ];
    #   locations."/" = {
    #     root = "/WD-RD0E4NHE/netbootxyz/assets";
    #     extraConfig = ''
    #       autoindex on;
    #     '';
    #   };
    # };
    "netboot.heyjohn.family" = {
      # enableACME = false;
      # rejectSSL = true;
      # acmeRoot = "/var/lib/acme/acme-challenge";
      # forceSSL = false;
      listenAddresses = [
        "192.168.130.4"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
    };
    "boot.heyjohn.family" = {
      # enableACME = false;
      # acmeRoot = "/var/lib/acme/acme-challenge";
      # rejectSSL = true;
      # forceSSL = false;
      listenAddresses = [
        "192.168.130.4"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8088";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
      locations."/talos" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:8088/talos";
        extraConfig = ''
          allow 192.168.130.131;
          allow 192.168.130.132;
          allow 192.168.130.133;
          allow 192.168.130.140;
          allow 192.168.130.141;
          allow 192.168.130.142;
          allow 192.168.130.143;
          allow 192.168.134.107;
          allow 192.168.130.4;
          allow 192.168.128.8;
          allow 192.168.128.3;
          deny all;
          # limit_except GET { deny all; }
          # if ($arg_mac) {
          #   return 302 http://$host/talos/config/$arg_mac;
          # }
          # try_files $uri =404;
          # return 400;
        '';
      };
    };
  };

}
