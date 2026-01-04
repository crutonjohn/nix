{ name, nodes, pkgs, lib, inputs, config, ... }: {

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
  locations."/" = {
      proxyPass = "http://${config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
      recommendedProxySettings = true;
  };
  useACMEHost = "fakecloudhost.heyjohn.family";
  forceSSL = true;
  listenAddresses = [
    "100.64.0.11"
  ];
};

}
