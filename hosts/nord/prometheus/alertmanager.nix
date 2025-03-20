{ name, nodes, pkgs, lib, inputs, config, ... }: {


sops = {
  secrets."prometheus/alertmanager/environmentFile" = {
    mode = "0440";
    group = "prometheus";
    owner = "prometheus";
    restartUnits = [ "alertmanager.service" ];
  };
};

services.nginx.virtualHosts = {
  "alerts.heyjohn.family" = {
    useACMEHost = "fakecloudhost.heyjohn.family";
    serverAliases = [ "alerts.ord.heyjohn.family" ];
    locations = {
      "/" = {
        proxyPass = "http://${config.services.prometheus.alertmanager.listenAddress}:${toString config.services.prometheus.alertmanager.port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
      # "/.well-known/acme-challenge/" = {
      #   root = "/var/lib/acme/acme-challenge";
      #   # extraConfig = ''
      #   #   rewrite /.well-known/acme-challenge/(.*) /$1 break;
      #   # '';
      # };
    };
    forceSSL = true;
    listenAddresses = [
      "100.64.0.9"
    ];
  };
};

# idea: use a fake virtualhost listening on public ip to get the cert
## and make sure the fake virtualhost has the real domain, but 
## they share the same useACMEHost directive.

services.prometheus.alertmanager = {
  enable = true;
  listenAddress = "127.0.0.1";
  port = 9093;
  environmentFile = "/run/secrets/prometheus/alertmanager/environmentFile";
  checkConfig = false;
  configText = ''
    global:
      resolve_timeout: 3m
    templates:
      - '/etc/alertmanager/templates/*.tmpl'
    receivers:
      - name: pushover
        pushover_configs:
          - token: $ENVIRONMENT $AM_PUSHOVER_TOKEN
            user_key: $ENVIRONMENT $AM_PUSHOVER_USER_KEY
      - name: discord_ark
        slack_configs:
          - api_url: $ENVIRONMENT $AM_DISCORD_ARK_SLACK_WEBHOOK
            channel: '#ark'

    inhibit_rules:
    - equal:
      - instance
      - alertname
      source_match:
        severity: critical
      target_match:
        severity: warning
    - target_match:
        alertname: Watchdog
    - target_match:
        alertname: KubeVersionMismatch
    - equal:
      - host
      source_match:
        alertname: ZfsOfflinePool
        job: node
      target_match:
        alertname: (ZfsPoolUnhealthy|ZfsDegradedPool)
    - equal:
      - host
      source_match:
        alertname: ZfsPoolUnhealthy
        job: zfs
      target_match:
        alertname: ZfsDegradedPool
        job: node
    - equal:
      - host
      source_match:
        alertname: ZfsCollectorFailed
        job: zfs
      target_match:
        job: zfs
    - equal:
      - instance
      source_match:
        alertname: PrometheusTargetMissing
      target_match:
        alertname: .*
    - equal:
      - instance
      - job
      source_match:
        alertname: BlackboxProbeFailed
      target_match:
        alertname: (BlackboxProbeHttpFailure|BlackboxICMPJobFailed|BlackboxHTTPJobFailed)
    - equal:
      - job
      source_match:
        alertname: InstanceDown
      target_match:
        alertname: (PrometheusAllTargetsMissing|PrometheusTargetMissing)
    - equal:
      - job
      source_match:
        alertname: PrometheusAllTargetsMissing
      target_match:
        alertname: (PrometheusTargetMissing)

    route:
      group_by:
      - instance
      - alertname
      group_interval: 5m
      group_wait: 30s
      receiver: pushover
      repeat_interval: 24h
      routes:
      - continue: true
        group_wait: 10s
        matchers:
        - container=~"(ark.*)"
        receiver: discord_ark
  '';

};

}
