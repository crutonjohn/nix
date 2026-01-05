{ ... }: {

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    logError = "stderr info";
    enableReload = true;
  };

  users.users.nginx.extraGroups = [ "acme" ];
  security.acme = {
    acceptTerms = true;
    defaults.email = "certs+crutonjohn@pm.me";
  };

}
