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
        endpoint: http://100.64.0.11:3100/otlp
    processors:
      batch:
        send_batch_max_size: 1500
        send_batch_size: 1000
        timeout: 1s
      transform/journald:
        error_mode: ignore
        log_statements:
          - context: log
            statements:
              # https://github.com/open-telemetry/opentelemetry-collector-contrib/issues/7298#issuecomment-3187693464
              #--- severity level priority
              - set(log.severity_number, SEVERITY_NUMBER_DEBUG) where Int(log.body["PRIORITY"]) == 7
              - set(log.severity_number, SEVERITY_NUMBER_INFO)  where Int(log.body["PRIORITY"]) == 6
              - set(log.severity_number, SEVERITY_NUMBER_INFO2) where Int(log.body["PRIORITY"]) == 5
              - set(log.severity_number, SEVERITY_NUMBER_WARN)  where Int(log.body["PRIORITY"]) == 4
              - set(log.severity_number, SEVERITY_NUMBER_ERROR) where Int(log.body["PRIORITY"]) == 3
              - set(log.severity_number, SEVERITY_NUMBER_FATAL) where Int(log.body["PRIORITY"]) <= 2
              - set(log.attributes["priority"], log.body["PRIORITY"])
              #--- severity level priority as text
              - set(log.attributes["severity"], "debug")  where Int(log.body["PRIORITY"]) == 7
              - set(log.attributes["severity"], "info")   where Int(log.body["PRIORITY"]) == 6
              - set(log.attributes["severity"], "info")   where Int(log.body["PRIORITY"]) == 5
              - set(log.attributes["severity"], "warn")   where Int(log.body["PRIORITY"]) == 4
              - set(log.attributes["severity"], "error")  where Int(log.body["PRIORITY"]) == 3
              - set(log.attributes["severity"], "fatal")  where Int(log.body["PRIORITY"]) <= 2
              #--- trace who and what generated log message
              - set(log.attributes["process.comm"],       String(log.body["_COMM"]))                where log.body["_COMM"] != nil
              - set(log.attributes["process.exec"],       String(log.body["_EXE"]))                 where log.body["_EXE"] != nil
              - set(log.attributes["process.uid"],        String(log.body["_UID"]))                 where log.body["_UID"] != nil
              - set(log.attributes["process.gid"],        String(log.body["_GID"]))                 where log.body["_GID"] != nil
              - set(log.attributes["owner_uid"],          String(log.body["_SYSTEMD_OWNER_UID"]))   where log.body["_SYSTEMD_OWNER_UID"] != nil
              - set(log.attributes["unit"],               String(log.body["_SYSTEMD_UNIT"]))        where log.body["_SYSTEMD_UNIT"] != nil
              - set(log.attributes["syslog_identifier"],  String(log.body["SYSLOG_IDENTIFIER"]))    where log.body["SYSLOG_IDENTIFIER"] != nil
              #--- create low cardinality "job" identifier
              # user@xxx.service mnt-xxx.mount run-xxx.scope session-xxx.scope
              ## ^([a-zA-Z_]{3,20})   ([^\\-\\.\\@0-9]+).*
              - set(log.attributes["syslog_identifier_prefix"], ConvertCase(log.body["SYSLOG_IDENTIFIER"], "lower")) where log.body["SYSLOG_IDENTIFIER"] != nil
              - replace_pattern(log.attributes["syslog_identifier_prefix"], "^[^a-zA-Z]*([a-zA-Z]{3,25}).*", "$$1") where log.body["SYSLOG_IDENTIFIER"] != nil
              - set(log.attributes["unit_prefix"], ConvertCase(log.body["_SYSTEMD_UNIT"], "lower")) where log.body["_SYSTEMD_UNIT"] != nil
              - replace_pattern(log.attributes["unit_prefix"], "^[^a-zA-Z]*([a-zA-Z]{3,25}).*", "$$1") where log.body["_SYSTEMD_UNIT"] != nil
              - set(log.attributes["job"], log.attributes["syslog_identifier_prefix"])
              - set(log.attributes["job"], log.attributes["unit_prefix"]) where log.attributes["job"] == nil and log.attributes["unit_prefix"] != nil
              - delete_key(log.attributes, "syslog_identifier_prefix")
              - delete_key(log.attributes, "unit_prefix")
              #--- set timestamp from _SOURCE_REALTIME_TIMESTAMP if available
              - set(log.time, Time(Int(log.body["_SOURCE_REALTIME_TIMESTAMP"]), "microseconds")) where log.body["_SOURCE_REALTIME_TIMESTAMP"] != nil
              #--- set hostname and resource attributes
              - set(log.attributes["hostname"], String(log.body["_HOSTNAME"])) where log.body["_HOSTNAME"] != nil
              - set(resource.attributes["host.name"], String(log.body["_HOSTNAME"])) where log.body["_HOSTNAME"] != nil
              - set(resource.attributes["host.id"], String(log.body["_MACHINE_ID"])) where log.body["_MACHINE_ID"] != nil
              - set(resource.attributes["process.pid"], log.body["_PID"])
              - set(resource.attributes["process.command_line"], log.body["_CMDLINE"])
              - set(resource.attributes["process.command"], log.body["_COMM"])
              - set(resource.attributes["process.executable.path"], log.body["_EXE"])
              - set(resource.attributes["service.name"], String(log.body["SYSLOG_IDENTIFIER"])) where log.body["SYSLOG_IDENTIFIER"] != nil
              - set(resource.attributes["service.name"], String(log.body["_SYSTEMD_UNIT"])) where resource.attributes["service.name"] == nil and log.body["_SYSTEMD_UNIT"] != nil
              - set(resource.attributes["service.name"], String(log.body["_COMM"])) where resource.attributes["service.name"] == nil and log.body["_COMM"] != nil
              - set(resource.attributes["service.name"], "unknown_service") where resource.attributes["service.name"] == nil
              - set(log.attributes["message"], log.body["MESSAGE"]) where log.body["MESSAGE"] != nil
              - set(log.body, log.body["MESSAGE"])
      groupbyattrs:
        keys:
          - service.name
          - host.name
          - receiver
          - job
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
            - transform/journald
            - groupbyattrs
            - batch
          exporters:
            - otlphttp
            - debug

  '';

}
