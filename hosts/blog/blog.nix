{ name, nodes, pkgs, lib, inputs, ... }: {

services.nginx = {
  enable = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  logError = "stderr info";
};

users.users.nginx.extraGroups = [ "acme" ];
security.acme = {
  acceptTerms = true;
  defaults.email = "certs+crutonjohn@pm.me";
};

services.nginx.virtualHosts = {
  "baremetalblog.com" = {
    useACMEHost = "baremetalblog.com";
    forceSSL = true;
    root = "${inputs.hugoBlog.packages.x86_64-linux.default}";
    locations."/" = {
      tryFiles = "$uri $uri/ =404";
      index = "index.html";
    };
  };
  "www.baremetalblog.com" = {
    useACMEHost = "baremetalblog.com";
    forceSSL = true;
    locations."/" = {
      return = "301 https://baremetalblog.com$request_uri";
    };
  };
};

security.acme.certs = {
  "baremetalblog.com" = {
    dnsProvider = "linode";
    # linode ns1
    #dnsResolver = "162.159.27.72:53";
    # https://go-acme.github.io/lego/dns/linode/
    # LINODE_TOKEN=xxxxx
    # https://search.nixos.org/options?channel=23.05&show=security.acme.certs.%3Cname%3E.domain&from=0&size=50&sort=relevance&type=packages&query=security.acme.certs
    # this has been manually created on the destination host for now.
    credentialsFile = "/var/lib/acme/linode/credentials";
    #credentialsFile = pkgs.writeText "linode-credentials"
    #  ''
    #  LINODE_TOKEN=8c3770cb3a0f5993247ea02405384c49311d0a0cbc60f04170b6d605cf61f952
    #  '';
    extraDomainNames = [
      "www.baremetalblog.com"
    ];
    group = "nginx";
  };
};

# setup pushing static site build artifact to linode

## integrate flake changes in this repo to main flake repo
## rename `nixos` repo to something else like `dootfiles` or maybe some other cool video game lore thing
## potentially create github action to keep blog up-to-date? re-deploy nightly?
## deploy site changes on push to main

}
