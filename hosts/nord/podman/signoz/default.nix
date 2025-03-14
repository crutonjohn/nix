# Partially auto-generated using compose2nix v0.3.0.
{ pkgs, lib, ... }:


{

  imports =
    [
      ./files
      ./nginx.nix
      ./certs.nix
    ];


  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
      # "JAEGER_ENDPOINT" = "http://otel-collector:14268/api/traces";
  virtualisation.oci-containers.containers."otel-migrator-async" = {
    image = "signoz/signoz-schema-migrator:0.111.5";
    cmd = [ "async" "--dsn=tcp://clickhouse:9000" "--up=" ];
    dependsOn = [
      "otel-migrator-sync"
      "signoz-clickhouse"
    ];
    log-driver = "k8s-file";
    extraOptions = [
      "--network-alias=otel-collector-migrator-async"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-otel-migrator-async" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
  };
  virtualisation.oci-containers.containers."otel-migrator-sync" = {
    image = "signoz/signoz-schema-migrator:0.111.29";
    cmd = [ "sync" "--dsn=tcp://clickhouse:9000" "--up=" ];
    dependsOn = [
      "signoz-clickhouse"
    ];
    log-driver = "k8s-file";
    extraOptions = [
      "--network-alias=otel-collector-migrator-sync"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-otel-migrator-sync" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
  };
  virtualisation.oci-containers.containers."signoz-alertmanager" = {
    image = "signoz/alertmanager:0.23.7";
    volumes = [
      "/etc/signoz/data/alertmanager:/data:rw"
    ];
    cmd = [ "--queryService.url=http://query-service:8085" "--storage.path=/data" ];
    dependsOn = [
      "signoz-query-service"
    ];
    log-driver = "k8s-file";
    extraOptions = [
      "--network-alias=alertmanager"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-alertmanager" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/data/alertmanager"
    ];
  };
  virtualisation.oci-containers.containers."signoz-clickhouse" = {
    image = "clickhouse/clickhouse-server:24.1.2-alpine";
    volumes = [
      "/etc/signoz/clickhouse/config/clickhouse-cluster.xml:/etc/clickhouse-server/config.d/cluster.xml:rw"
      "/etc/signoz/clickhouse/config/clickhouse-config.xml:/etc/clickhouse-server/config.xml:rw"
      "/etc/signoz/clickhouse/config/clickhouse-users.xml:/etc/clickhouse-server/users.xml:rw"
      "/etc/signoz/clickhouse/config/custom-function.xml:/etc/clickhouse-server/custom-function.xml:rw"
      "/etc/signoz/data/clickhouse:/var/lib/clickhouse:rw"
      "/etc/signoz/clickhouse/user_scripts:/var/lib/clickhouse/user_scripts:rw"
    ];
    ports = [
      "127.0.0.1:9000:9000/tcp"
      "127.0.0.1:8123:8123/tcp"
      "127.0.0.1:9181:9181/tcp"
    ];
    dependsOn = [
      "signoz-zookeeper-1"
    ];
    extraOptions = [
      "--health-cmd=[\"wget\", \"--spider\", \"-q\", \"0.0.0.0:8123/ping\"]"
      "--health-interval=30s"
      "--health-retries=3"
      "--health-timeout=5s"
      "--hostname=clickhouse"
      "--log-opt=max-file=3"
      "--log-opt=max-size=50m"
      "--network-alias=clickhouse"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-clickhouse" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/clickhouse/config/clickhouse-cluster.xml"
      "/etc/signoz/clickhouse/config/clickhouse-config.xml"
      "/etc/signoz/clickhouse/config/clickhouse-users.xml"
      "/etc/signoz/clickhouse/config/custom-function.xml"
      "/etc/signoz/data/clickhouse"
      "/etc/signoz/clickhouse/config/user_scripts"
    ];
  };
  virtualisation.oci-containers.containers."signoz-frontend" = {
    image = "signoz/frontend:0.74.0";
    volumes = [
      "/etc/signoz/frontend/nginx-config.conf:/etc/nginx/conf.d/default.conf:rw"
    ];
    ports = [
      "127.0.0.1:3301:3301/tcp"
    ];
    dependsOn = [
      "signoz-alertmanager"
      "signoz-query-service"
    ];
    log-driver = "k8s-file";
    extraOptions = [
      "--network-alias=frontend"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-frontend" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/frontend/nginx-config.conf"
    ];
  };
  virtualisation.oci-containers.containers."signoz-otel-collector" = {
    image = "signoz/signoz-otel-collector:0.111.29";
    environment = {
      "LOW_CARDINAL_EXCEPTION_GROUPING" = "false";
      "OTEL_RESOURCE_ATTRIBUTES" = "host.name=otelgw.internal.heyjohn.family,os.type=linux";
    };
    volumes = [
      "/etc/signoz/otel-collector/otel-collector-config.yaml:/etc/otel-collector-config.yaml:rw"
      "/etc/signoz/otel-collector/otel-collector-opamp-config.yaml:/etc/manager-config.yaml:rw"
      "/var/lib/acme/otelgw.internal.heyjohn.family:/var/lib/acme/otelgw.internal.heyjohn.family:ro"
      "/var/lib/containers:/var/lib/containers:ro"
    ];
    ports = [
      "0.0.0.0:4317:4317/tcp"
      "0.0.0.0:4318:4318/tcp"
    ];
    cmd = [ "--config=/etc/otel-collector-config.yaml" "--manager-config=/etc/manager-config.yaml" "--copy-path=/var/tmp/collector-config.yaml" "--feature-gates=-pkg.translator.prometheus.NormalizeName" ];
    dependsOn = [
      "otel-migrator-sync"
      "signoz-clickhouse"
      "signoz-query-service"
    ];
    user = "root";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=otel-collector"
      "--network=signoz_default"
      # "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-otel-collector" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/otel-collector/otel-collector-config.yaml"
      "/etc/signoz/otel-collector/otel-collector-opamp-config.yaml"
      "/var/log/container"
    ];
  };
  virtualisation.oci-containers.containers."signoz-query-service" = {
    image = "signoz/query-service:0.74.0";
    environment = {
      "ALERTMANAGER_API_PREFIX" = "http://alertmanager:9093/api/";
      "ClickHouseUrl" = "tcp://clickhouse:9000";
      "DASHBOARDS_PATH" = "/root/config/dashboards";
      "DEPLOYMENT_TYPE" = "docker-standalone-amd";
      "GODEBUG" = "netdns=go";
      "SIGNOZ_LOCAL_DB_PATH" = "/var/lib/signoz/signoz.db";
      "STORAGE" = "clickhouse";
      "TELEMETRY_ENABLED" = "true";
    };
    volumes = [
      "/etc/signoz/data/query:/var/lib/signoz:rw"
      "/etc/signoz/prometheus/prometheus.yml:/root/config/prometheus.yml:rw"
      "/etc/signoz/data/dashboards:/root/config/dashboards:rw"
    ];
    cmd = [ "-config=/root/config/prometheus.yml" "--use-logs-new-schema=true" ];
    dependsOn = [
      "otel-migrator-sync"
      "signoz-clickhouse"
    ];
    log-driver = "k8s-file";
    extraOptions = [
      "--health-cmd=[\"wget\", \"--spider\", \"-q\", \"localhost:8080/api/v1/health\"]"
      "--health-interval=30s"
      "--health-retries=3"
      "--health-timeout=5s"
      "--network-alias=query-service"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-query-service" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "on-failure";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/data/query"
      "/etc/signoz/prometheus/prometheus.yml"
      "/etc/signoz/data/dashboards"
    ];
  };
  virtualisation.oci-containers.containers."signoz-zookeeper-1" = {
    image = "bitnami/zookeeper:3.7.1";
    environment = {
      "ALLOW_ANONYMOUS_LOGIN" = "yes";
      "ZOO_AUTOPURGE_INTERVAL" = "1";
      "ZOO_SERVER_ID" = "1";
    };
    volumes = [
      "/etc/signoz/data/zookeeper-1:/bitnami/zookeeper:rw"
    ];
    ports = [
      "100.64.0.9:2181:2181/tcp"
      "100.64.0.9:2888:2888/tcp"
      "100.64.0.9:3888:3888/tcp"
    ];
    user = "root";
    log-driver = "k8s-file";
    extraOptions = [
      "--hostname=zookeeper-1"
      "--network-alias=zookeeper-1"
      "--network=signoz_default"
      "--log-opt=max-size=10mb"
      #"--log-opt=path=/var/log/container/{{.Name}}.json"

    ];
  };
  systemd.services."podman-signoz-zookeeper-1" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "no";
    };
    after = [
      "podman-network-signoz_default.service"
    ];
    requires = [
      "podman-network-signoz_default.service"
    ];
    partOf = [
      "podman-compose-signoz-root.target"
    ];
    wantedBy = [
      "podman-compose-signoz-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/etc/signoz/data/zookeeper-1"
    ];
  };

  # Networks
  systemd.services."podman-network-signoz_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f signoz_default";
    };
    script = ''
      podman network inspect signoz_default || podman network create signoz_default
    '';
    partOf = [ "podman-compose-signoz-root.target" ];
    wantedBy = [ "podman-compose-signoz-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-signoz-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
