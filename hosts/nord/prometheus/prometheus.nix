{ name, nodes, pkgs, lib, inputs, config, ... }: {

services.nginx.virtualHosts = {
  "prometheus.heyjohn.family" = {
    useACMEHost = "fakecloudhost.heyjohn.family";
    serverAliases = [ "prometheus.ord.heyjohn.family" ];
    locations = {
      "/" = {
        proxyPass = "http://${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
    forceSSL = true;
    listenAddresses = [
      "100.64.0.9"
    ];
  };
};

environment.etc = {
    "prometheus/targets".source = ./targets;
    "prometheus/rules".source = ./rules;
};

sops = {
  secrets = {
    "prometheus/minio/bench/cluster-token" = {
      owner = "prometheus";
    };
    "prometheus/minio/bench/node-token" = {
      owner = "prometheus";
    };
    "prometheus/minio/bench/bucket-token" = {
      owner = "prometheus";
    };
    "prometheus/minio/bench/resource-token" = {
      owner = "prometheus";
    };
  };
};

services.prometheus = {
  enable = true;
  listenAddress = "100.64.0.9";
  port = 9090;
  enableReload = true;
  retentionTime = "30d";
  checkConfig = false;
  extraFlags = [
    "--web.enable-remote-write-receiver"
    "--web.enable-lifecycle"
    "--web.external-url https://prometheus.heyjohn.family"
  ];
  ruleFiles = [
    "/etc/prometheus/rules/*.rules"
  ];
  globalConfig = {
    scrape_interval = "60s";
    scrape_timeout = "20s";
    evaluation_interval = "30s";
    external_labels = {
      datacenter = "ord";
    };
  };
  alertmanagers = [{
      static_configs = [{
        targets = ["${config.services.prometheus.alertmanager.listenAddress}:${toString config.services.prometheus.alertmanager.port}"];
      }];
  }];

  scrapeConfigs = [
    {
      job_name = "prometheus";
      static_configs = [
        {
          targets = [
            "prometheus.heyjohn.family:9090"
          ];
          labels = {
            environment = "production";
            datacenter = "ord";
          };
        }
        {
          targets = [
            "prom-lyh.heyjohn.family:9090"
          ];
          labels = {
            environment = "production";
            datacenter = "lyh";
          };
        }
      ];
      relabel_configs = [
        {
          # Extract hostname from target
          source_labels = [ "__address__" ];
          regex = "(.*):.*";
          target_label = "instance";
          replacement = "$1";
        }
      ];
    }
    {
      job_name = "alertmanager";
      metrics_path = "/metrics";
      static_configs = [
        {
          targets = [
            "${config.services.prometheus.alertmanager.listenAddress}:${toString config.services.prometheus.alertmanager.port}"
          ];
          labels = {
            datacenter = "ord";
            instance = "alerts.heyjohn.family";
          };
        }
      ];
    }
    {
      job_name = "headscale";
      metrics_path = "/metrics";
      static_configs = [{
        targets = [ "${config.services.headscale.settings.metrics_listen_addr}" ];
        labels = {
          datacenter = "ord";
          instance = "headscale.heyjohn.family";
        };
      }];
    }
    {
      job_name = "node";
      metrics_path = "/metrics";
      file_sd_configs = [{
        files = [
          "/etc/prometheus/targets/nodes-internal.yaml"
          "/etc/prometheus/targets/nodes-external.yaml"
          "/etc/prometheus/targets/user.yaml"
        ];
      }];
      relabel_configs = [{
        source_labels = [ "__address__" ];
        regex = "(.*):(.*)";
        replacement = "$1";
        target_label = "instance";
      }];
    }
    {
      # gets renamed to node
      job_name = "node_local";
      metrics_path = "/metrics";
      static_configs = [{
        targets = [ "${config.services.prometheus.exporters.node.listenAddress}:${toString config.services.prometheus.exporters.node.port}" ];
        labels = {
          datacenter = "ord";
          instance = "nord.heyjohn.family";
          service = "omnibus";
        };
      }];
      relabel_configs = [
        {
          source_labels = [ "job"];
          regex = "(.*)";
          replacement = "node";
          target_label = "job";
        }
      ];
    }
    {
      job_name = "blackbox_exporter";
      scrape_timeout = "15s";
      metrics_path = "/metrics";
      static_configs = [{
        targets = [ "${config.services.prometheus.exporters.blackbox.listenAddress}:${toString config.services.prometheus.exporters.blackbox.port}" ];
      }];
    }
    {
      job_name = "blackbox_http";
      scrape_timeout = "15s";
      scrape_interval = "60s";
      metrics_path = "/probe";
      params = {
        module = [ "http_2xx" ];
      };
      file_sd_configs = [{
        files = [ "/etc/prometheus/targets/blackbox_http.yaml" ];
      }];
      relabel_configs = [
        {
          source_labels = [ "__address__" ];
          target_label = "__param_target";
        }
        {
          source_labels = [ "__param_target" ];
          target_label = "instance";
        }
        {
          target_label = "__address__";
          replacement = "${config.services.prometheus.exporters.blackbox.listenAddress}:${toString config.services.prometheus.exporters.blackbox.port}";
        }
      ];
    }
    {
      # gets renamed to blackbox_icmp
      job_name = "blackbox_icmp_external";
      scrape_timeout = "15s";
      scrape_interval = "60s";
      metrics_path = "/probe";
      params = {
        module = [ "icmp_external" ];
      };
      file_sd_configs = [{
        files = [ "/etc/prometheus/targets/nodes-external.yaml" ];
      }];
      relabel_configs = [
        {
          source_labels = [ "__address__" ];
          regex = "(.*):(.*)";
          replacement = "$1";
          target_label = "__param_target";
        }
        {
          source_labels = [ "__param_target" ];
          target_label = "instance";
        }
        {
          target_label = "__address__";
          replacement = "${config.services.prometheus.exporters.blackbox.listenAddress}:${toString config.services.prometheus.exporters.blackbox.port}";
        }
        {
          source_labels = [ "job"];
          regex = "(.*)";
          replacement = "blackbox_icmp";
          target_label = "job";
        }
      ];
    }
    {
      # gets renamed to blackbox_icmp
      job_name = "blackbox_icmp_internal";
      scrape_timeout = "15s";
      scrape_interval = "60s";
      metrics_path = "/probe";
      params = {
        module = [ "icmp_internal" ];
      };
      file_sd_configs = [{
        files = [ "/etc/prometheus/targets/nodes-internal.yaml" ];
      }];
      relabel_configs = [
        {
          source_labels = [ "__address__" ];
          regex = "(.*):(.*)";
          replacement = "$1";
          target_label = "__param_target";
        }
        {
          source_labels = [ "__param_target" ];
          target_label = "instance";
        }
        {
          target_label = "__address__";
          replacement = "${config.services.prometheus.exporters.blackbox.listenAddress}:${toString config.services.prometheus.exporters.blackbox.port}";
        }
        {
          source_labels = [ "job"];
          regex = "(.*)";
          replacement = "blackbox_icmp";
          target_label = "job";
        }
      ];
    }
    #{
    #  job_name = "omada";
    #  scrape_timeout = "30s";
    #  scrape_interval = "60s";
    #  metrics_path = "/metrics";
    #  file_sd_configs = [{
    #    files = [ "/etc/prometheus/targets/omada.yaml" ];
    #  }];
    #}
    {
      job_name = "loki";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/metrics";
      static_configs = [
        {
          targets = [ "100.64.0.9:3100" ];
          labels = {
            datacenter = "ord";
            instance = "loki.heyjohn.family";
          };
        }
      ];
    }
    {
      job_name = "pihole";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/metrics";
      file_sd_configs = [{
        files = [ "/etc/prometheus/targets/pihole.yaml" ];
      }];
    }
    {
      job_name = "minio-job";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/minio/v2/metrics/cluster";
      authorization = {
        type = "Bearer";
        credentials_file = "/run/secrets/prometheus/minio/bench/cluster-token";
      };
      static_configs = [
        {
          targets = [ "workbench.heyjohn.family:9000" ];
          labels = {
            datacenter = "lyh";
            #instance = "loki.heyjohn.family";
          };
        }
      ];
    }
    {
      job_name = "minio-job-node";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/minio/v2/metrics/node";
      authorization = {
        type = "Bearer";
        credentials_file = "/run/secrets/prometheus/minio/bench/node-token";
      };
      static_configs = [
        {
          targets = [ "workbench.heyjohn.family:9000" ];
          labels = {
            datacenter = "lyh";
            #instance = "loki.heyjohn.family";
          };
        }
      ];
    }
    {
      job_name = "minio-job-bucket";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/minio/v2/metrics/bucket";
      authorization = {
        type = "Bearer";
        credentials_file = "/run/secrets/prometheus/minio/bench/bucket-token";
      };
      static_configs = [
        {
          targets = [ "workbench.heyjohn.family:9000" ];
          labels = {
            datacenter = "lyh";
            #instance = "loki.heyjohn.family";
          };
        }
      ];
    }
    {
      job_name = "minio-job-resource";
      scrape_timeout = "30s";
      scrape_interval = "60s";
      metrics_path = "/minio/v2/metrics/resource";
      authorization = {
        type = "Bearer";
        credentials_file = "/run/secrets/prometheus/minio/bench/resource-token";
      };
      static_configs = [
        {
          targets = [ "workbench.heyjohn.family:9000" ];
          labels = {
            datacenter = "lyh";
            #instance = "loki.heyjohn.family";
          };
        }
      ];
    }
  ];
};

}
