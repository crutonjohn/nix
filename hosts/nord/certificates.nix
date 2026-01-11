{ pkgs, ... }:

{

systemd.timers."renew-step-cert" = {
  wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 0/20:00:00"; # Runs every 20 hours
      Unit = "renew-step-cert.service";
    };
};

systemd.services."renew-step-cert" = {
  script = ''
    set -eu
    ${pkgs.step-cli}/bin/step ca certificate nord.heyjohn.family /var/lib/acme/nord.heyjohn.family/cert.tmp /var/lib/acme/nord.heyjohn.family/key.tmp --webroot "/var/lib/acme/acme-challenge" --san "alerts.ord.heyjohn.family" --san "alerts.heyjohn.family" --san "prometheus.ord.heyjohn.family" --san "prometheus.heyjohn.family" --san "grafana.heyjohn.family" --san "headscale.heyjohn.family" --not-after="24h" --provisioner registration-authority --provisioner-password-file /root/.step/registration-authority-pass
    mv /var/lib/acme/nord.heyjohn.family/cert.tmp /var/lib/acme/nord.heyjohn.family/cert.pem
    mv /var/lib/acme/nord.heyjohn.family/key.tmp /var/lib/acme/nord.heyjohn.family/key.pem
    chown acme:nginx /var/lib/acme/nord.heyjohn.family/cert.pem
    chown acme:nginx /var/lib/acme/nord.heyjohn.family/key.pem
    chmod 640 /var/lib/acme/nord.heyjohn.family/cert.pem
    chmod 640 /var/lib/acme/nord.heyjohn.family/key.pem
    rm -f /var/lib/acme/nord.heyjohn.family/*.tmp
  '';
  serviceConfig = {
    Type = "oneshot";
    User = "root";
    Group = "root";
    RemainAfterExit = true; # Prevents the service from automatically starting on rebuild.
  };
};

}
