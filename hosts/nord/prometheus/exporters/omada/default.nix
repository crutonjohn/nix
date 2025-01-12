{ ... }: {

imports = [ ../../../../../modules/omada-exporter ];

  services.omada-exporter = {
      enable = true;
      environmentFile = "/run/secrets/prometheus/exporters/omada/environmentFile";
  };

}