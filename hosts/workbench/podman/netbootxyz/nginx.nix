{ ... }:

{

  services.nginx.virtualHosts = {
    "netboot.heyjohn.family" = {
      enableACME = false;
      acmeRoot = "/var/lib/acme/acme-challenge";
      forceSSL = false;
      listenAddresses = [
        "192.168.128.5"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
    };
    "boot.heyjohn.family" = {
      enableACME = false;
      acmeRoot = "/var/lib/acme/acme-challenge";
      forceSSL = false;
      listenAddresses = [
        "192.168.128.5"
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:8080";
        recommendedProxySettings = true;
        proxyWebsockets = true;
      };
    };
  };

}
