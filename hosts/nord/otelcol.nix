{ pkgs, ... }: {

  services.opentelemetry-collector = {
    enable = true;
    package = pkgs.opentelemetry-collector-contrib;
    configFile = "/etc/otelcol/config.yaml";
  };

  environment.etc."otelcol/config.yaml".text = ''
    receivers:
      journald:
      directory: /var/log/journal
      units:
        - prometheus
        - loki
        - grafana
        - alertmanager
        - headscale
        - nginx
    exporters:
      debug: {}
      otlphttp:
        endpoint: http://100.64.0.9:3100/otlp
    processors:
      batch:
        send_batch_max_size: 1500
        send_batch_size: 1000
        timeout: 1s
        passthrough: false
    service:
      telemetry:
        metrics:
          level: detailed
          readers:
            - pull:
                exporter:
                  prometheus:
                    host: 127.0.0.1
                    port: 8888
      pipelines:
        logs:
          receivers:
            - journald
          processors:
            - batch
          exporters:
            - otlphttp

  '';

}
