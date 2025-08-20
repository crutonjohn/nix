{ ... }: {

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    logError = "stderr info";
    enableReload = true;
  };

  users.users.nginx.extraGroups = [ "acme" ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "certs+crutonjohn@pm.me";
  };

  # sacrificial virtualhost listening on public ip to facilitate certs
  security.acme.certs = {
    "fakecloudhost.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      webroot = "/var/lib/acme/acme-challenge";
      extraDomainNames = [
        "alerts.ord.heyjohn.family"
        "alerts.heyjohn.family"
        "prometheus.ord.heyjohn.family"
        "prometheus.heyjohn.family"
        "grafana.heyjohn.family"
      ];
      email = "curtis@heyjohn.family";
      renewInterval = "* 23:00:00";
      reloadServices = [
        "prometheus.service"
        "alertmanager.service"
        "loki.service"
        "grafana.service"
      ];
      group = "nginx";
    };
  };

  # hack to get step certs via ACME
  services.nginx.virtualHosts = {
    "acme" = {
      enableACME = false;
      forceSSL = false;
      default = true;
      serverName = "fakecloudhost.heyjohn.family";
      locations."/.well-known/acme-challenge/" = {
        root = "/var/lib/acme/acme-challenge";
      };
    };
  };

  systemd.timers."custom-acme-fakecloudhost.heyjohn.family" = {
    description = "Hack to renew ACME Certificate every day";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 22:00:00";
      Persistent = "yes";
      AccuracySec = "600s";
      Unit = "acme-fakecloudhost.heyjohn.family.service";
    };
  };

}
