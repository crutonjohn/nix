{ ... }: {

  sops = {
    secrets."headscale/oidc_client_secret" = {
      mode = "0440";
      group = "headscale";
      owner = "headscale";
      restartUnits = [ "headscale.service" ];
    };
  };

  networking.hosts = { "127.0.0.1" = [ "headscale.heyjohn.family" ]; };

  services.headscale = {
    enable = true;
    port = 8080;
    address = "127.0.0.1";
    settings = {
      metrics_listen_addr = "127.0.0.1:9080";
      server_url = "https://headscale.heyjohn.family";
      dns = {
        override_local_dns = true;
        nameservers.global = [ "192.168.130.2" "192.168.130.3" ];
        magic_dns = false;
        # base_domain = "vpn.heyjohn.family";
      };
      log = {
        level = "info";
        format = "json";
      };
      oidc = {
        issuer = "https://accounts.google.com";
        client_id =
          "638202268064-71mv6t58das0tsdjahoebi6s6s2ktau5.apps.googleusercontent.com";
        # secret handled by sops now
        #client_secret_path = "/var/lib/headscale/oidc_client_secret";
        client_secret_path = "/run/secrets/headscale/oidc_client_secret";
        scope = [ "openid" "profile" "email" ];
        extra_params = { domain_hint = "heyjohn.family"; };
        allowed_domains = [ "heyjohn.family" ];
      };
    };
  };

  services.nginx.virtualHosts = {
    "headscale.heyjohn.family" = {
      enableACME = false;
      sslCertificate = "/var/lib/acme/nord.heyjohn.family/cert.pem";
      sslCertificateKey = "/var/lib/acme/nord.heyjohn.family/key.pem";
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
