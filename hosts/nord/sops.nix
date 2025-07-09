{
  #imports = [ <sops-nix/modules/sops> ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      "acme/linode/credentials" = { };
      "acme/step/environmentFile" = { };
      "headscale/oidc_client_secret" = { };
      "tailscale/nord/preauthkey" = { };
      "alertmanager/environmentFile" = { };
      "prometheus/exporters/omada/environmentFile" = { };
      "prometheus/alertmanager/environmentFile" = { };
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
}
