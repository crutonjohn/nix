{ pkgs, ... }:

{

  # systemd.timers."renew-step-cert" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnCalendar = "*-*-* 0/20:00:00"; # Runs every 20 hours
  #     Unit = "renew-step-cert.service";
  #   };
  # };

  # systemd.services."renew-step-cert" = {
  #   script = ''
  #     set -eu
  #     ${pkgs.step-cli}/bin/step ca certificate \
  #       nord.heyjohn.family \
  #       /var/lib/acme/nord.heyjohn.family/cert.tmp \
  #       /var/lib/acme/nord.heyjohn.family/key.tmp \
  #       --webroot "/var/lib/acme/acme-challenge" \
  #       --san "alerts.ord.heyjohn.family" \
  #       --san "alerts.heyjohn.family" \
  #       --san "prometheus.ord.heyjohn.family" \
  #       --san "prometheus.heyjohn.family" \
  #       --san "grafana.heyjohn.family" \
  #       --san "headscale.heyjohn.family" \
  #       --not-after="24h" \
  #       --provisioner k8s-registration-authority \
  #       --provisioner-password-file /root/.step/registration-authority-pass
  #     mv /var/lib/acme/nord.heyjohn.family/cert.tmp /var/lib/acme/nord.heyjohn.family/cert.pem
  #     mv /var/lib/acme/nord.heyjohn.family/key.tmp /var/lib/acme/nord.heyjohn.family/key.pem
  #     chown acme:nginx /var/lib/acme/nord.heyjohn.family/cert.pem
  #     chown acme:nginx /var/lib/acme/nord.heyjohn.family/key.pem
  #     chmod 640 /var/lib/acme/nord.heyjohn.family/cert.pem
  #     chmod 640 /var/lib/acme/nord.heyjohn.family/key.pem
  #     rm -f /var/lib/acme/nord.heyjohn.family/*.tmp
  #     systemctl reload nginx
  #   '';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "root";
  #     Group = "root";
  #     RemainAfterExit = true; # Prevents the service from automatically starting on rebuild.
  #   };
  # };

  services.nginx.virtualHosts = {
    "nord.heyjohn.family" = {
      forceSSL = false;
      locations."/.well-known/acme-challenge/" = {
        proxyPass = "http://127.0.0.1:1360/";
      };
    };
  };

  security.acme.certs = {
    "nord.heyjohn.family" = {
      server = "https://ra.heyjohn.family/acme/acme/directory";
      enableDebugLogs = true;
      # webroot = "/var/lib/acme/acme-challenge";
      email = "curtis@heyjohn.family";
      listenHTTP = "127.0.0.1:1360";
      extraLegoFlags = [ ];
      group = "nginx";
      extraDomainNames = [
        "alerts.ord.heyjohn.family"
        "alerts.heyjohn.family"
        "prometheus.ord.heyjohn.family"
        "prometheus.heyjohn.family"
        "grafana.heyjohn.family"
        "headscale.heyjohn.family"
      ];
    };
  };

  systemd.timers = {
    "custom-acme-nord.heyjohn.family" = {
      description = "Hack to renew internal ACME Certificate every day";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 22:00:00";
        Persistent = "yes";
        AccuracySec = "600s";
        Unit = "acme-order-renew-nord.heyjohn.family.service";
      };
    };
  };

}
