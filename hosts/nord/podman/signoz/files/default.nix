{ pkgs, lib, ... }:

{
    environment.etc = {
        "signoz/clickhouse".source = ./clickhouse;
    };

    environment.etc = {
        "signoz/alertmanager/alertmanager.yml".source = ./alertmanager/alertmanager.yml;
    };

    environment.etc = {
        "signoz/prometheus/prometheus.yml".source = ./prometheus/prometheus.yml;
    };

    environment.etc = {
        "signoz/prometheus/rules".source = ./prometheus/rules;
    };

    environment.etc = {
        "signoz/load-testing/locust-scripts".source = ./locust-scripts;
    };

    environment.etc = {
        "signoz/frontend/nginx-config.conf".source = ./frontend/nginx-config.conf;
    };

    environment.etc = {
        "signoz/otel-collector/otel-collector-config.yaml".source = ./otel-collector/otel-collector-config.yaml;
    };

    environment.etc = {
        "signoz/otel-collector/otel-collector-opamp-config.yaml".source = ./otel-collector/otel-collector-opamp-config.yaml;
    };

}
