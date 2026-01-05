{ pkgs, ... }:

{
  systemd.timers.step-cert-renew = {
    description = "Run Step CA certificate renewal every 20 hours";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 0/20:00:00"; # Runs every 20 hours
      Persistent = true;
    };
    unitConfig = {
      ExecStart = "${pkgs.step-cli}/bin/step ca certificate nord.heyjohn.family /var/lib/acme/nord.heyjohn.family/cert.pem /var/lib/acme/nord.heyjohn.family/key.pem --webroot \"/var/lib/acme/acme-challenge\" --san \"alerts.ord.heyjohn.family\" --san \"alerts.heyjohn.family\" --san \"prometheus.ord.heyjohn.family\" --san \"prometheus.heyjohn.family\" --san \"grafana.heyjohn.family\" --not-after=\"24h\" --provisioner registration-authority --provisioner-password-file /root/.step/registration-authority-pass";
      ExecStartPost = ''
        chown acme:nginx /var/lib/acme/nord.heyjohn.family/cert.pem
        chown acme:nginx /var/lib/acme/nord.heyjohn.family/key.pem
      '';
      User = "root";
      Group = "root";
    }; # Reuse the service configuration
  };

}
