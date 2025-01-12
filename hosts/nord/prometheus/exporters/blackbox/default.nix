{ config, pkgs, lib, ... }: {

  environment.etc = {
      "signoz/exporters/blackbox.yaml".source = ./files/blackbox.yaml;
  };

  services.prometheus.exporters = {
    blackbox = {
      enable = true;
      openFirewall = true;
      listenAddress = "100.64.0.9";
      port = 9115;
      configFile = ./files/blackbox.yaml;
    };
  };

}