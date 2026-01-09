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
    };
  };

}
