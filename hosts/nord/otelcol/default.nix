{ name, nodes, pkgs, lib, inputs, ... }: {

  environment.etc = {
    "otelcol/config.yaml".source = ./otelcol.yaml;
  };


  services.opentelemetry-collector = {
    enable = true;
    package = pkgs.otelcol;
    configFile = "/etc/otelcol/config.yaml";
  };

}
