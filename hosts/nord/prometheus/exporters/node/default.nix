{ config, pkgs, lib, ... }: {

  services.prometheus.exporters = {
    node = {
      enable = true;
      openFirewall = true;
      listenAddress = "100.64.0.11";
      port = 9100;
    };
  };

}
