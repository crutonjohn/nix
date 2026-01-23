{
  config,
  ...
}:
{

  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "127.0.0.1";
      http_port = 2333;
      domain = "grafana.heyjohn.family";
      root_url = "https://grafana.heyjohn.family/";
    };
  };

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    locations = {
      "/" = {
        proxyPass = "http://${config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
      "/.well-known/acme-challenge/" = {
        proxyPass = "http://127.0.0.1:1360/";
      };
    };
    sslCertificate = "/var/lib/acme/nord.heyjohn.family/cert.pem";
    sslCertificateKey = "/var/lib/acme/nord.heyjohn.family/key.pem";
    forceSSL = true;
    listenAddresses = [
      "100.64.0.11"
    ];
  };

}
