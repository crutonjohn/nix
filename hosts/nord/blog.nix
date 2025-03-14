{ name, nodes, pkgs, lib, inputs, config, ... }:

{

services.nginx.virtualHosts = {
  "baremetalblog.com" = {
    useACMEHost = "baremetalblog.com";
    forceSSL = true;
    root = "${pkgs.baremetalblog}";
    locations."/" = {
      tryFiles = "$uri $uri/ =404";
      index = "index.html";
    };
  };
  "www.baremetalblog.com" = {
    locations."/" = {
      return = "301 https://baremetalblog.com$request_uri";
    };
  };
};

sops = {
  secrets."acme/linode/credentials" = {
    mode = "0440";
    group = "nginx";
    owner = "acme";
  };
};

security.acme.certs = {
  "baremetalblog.com" = {
    dnsProvider = "linode";
    dnsResolver = "172.232.0.18:53";
    enableDebugLogs = true;
    # https://go-acme.github.io/lego/dns/linode/
    # https://search.nixos.org/options?channel=23.05&show=security.acme.certs.%3Cname%3E.domain&from=0&size=50&sort=relevance&type=packages&query=security.acme.certs
    environmentFile = "/var/lib/acme/linode/credentials";
    extraDomainNames = [
    ];
    group = "nginx";
  };
};


## integrate flake changes in this repo to main flake repo
## rename `nixos` repo to something else like `dootfiles` or maybe some other cool video game lore thing
## potentially create github action to keep blog up-to-date? re-deploy nightly?
## deploy site changes on push to main

}
