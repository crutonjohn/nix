{ name, nodes, pkgs, lib, inputs, ... }: {

sops = {
  secrets."headscale/oidc_client_secret" = {
    mode = "0440";
    group = "headscale";
    owner = "headscale";
    restartUnits = [ "headscale.service" ];
  };
};

services.headscale = {
  enable = true;
  port = 8080;
  address = "127.0.0.1";
  settings = {
    server_url = "https://headscale.heyjohn.family";
    dns_config = {
      override_local_dns = true;
      nameservers = [
        "192.168.130.1"
        "9.9.9.9"
      ];
      magic_dns = true;
      base_domain = "heyjohn.family";
    };
    log = {
      level = "info";
      format = "json";
    };
    oidc = {
     issuer = "https://accounts.google.com";
     client_id = "638202268064-71mv6t58das0tsdjahoebi6s6s2ktau5.apps.googleusercontent.com";
     # secret handled by sops now
     #client_secret_path = "/var/lib/headscale/oidc_client_secret";
     client_secret_path = "/run/secrets/headscale/oidc_client_secret";
     scope = [
       "openid"
       "profile"
       "email"
     ];
     strip_email_domain = true;
     extra_params = {
       domain_hint = "heyjohn.family";
     };
     allowed_domains = [
       "heyjohn.family"
     ];
    };
  };
};

services.nginx.virtualHosts = {
  "headscale.heyjohn.family" = {
    enableACME = true;
    acmeRoot = "/var/lib/acme/acme-challenge";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080/";
      recommendedProxySettings = false;
      extraConfig = ''
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header Host $server_name;
        proxy_redirect http:// https://;
        proxy_buffering off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
        add_header Strict-Transport-Security "max-age=15552000; includeSubDomains" always;
      '';
    };
  };
};
}
