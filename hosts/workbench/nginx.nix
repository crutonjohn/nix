{ ... }: {

services.nginx = {
  enable = true;
  recommendedProxySettings = true;
  recommendedTlsSettings = true;
  logError = "stderr info";
  enableReload = true;
  # defaultListen = [
  #   { addr = "192.168.130.4"; proxyProtocol = true; ssl = true; }
  # ]

};

users.users.nginx.extraGroups = [ "acme" ];
security.acme = {
  acceptTerms = true;
  defaults.email = "certs+crutonjohn@pm.me";
};

# sacrificial virtualhost listening on public ip to facilitate certs
# security.acme.certs = {
#   "workbench.heyjohn.family" = {
#     server = "https://ra.heyjohn.family/acme/acme/directory";
#     enableDebugLogs = true;
#     # environmentFile = "/run/secrets/acme/step/environmentFile";
#     webroot = "/var/lib/acme/acme-challenge";
#     # extraDomainNames = [
#     #   "minio-garage.heyjohn.family"
#     #   "s3-garage.heyjohn.family"
#     # ];
#     email = "curtis@heyjohn.family";
#     extraLegoFlags = [
#     ];
#     group = "nginx";
#   };
# };

}
