{ name, nodes, pkgs, lib, inputs, ... }: {

imports =
  [
    ../global

    #./podman
    #./otelcol

    ./loki
    ./grafana
    ./prometheus
    ./blog.nix
    ./hardware-configuration.nix
    ./headscale.nix
    ./nginx.nix
    ./sops.nix
    ./tailscale.nix
  ];

boot.loader.grub.enable = true;
networking.hostName = "nixos-us-ord"; # Define your hostname.
networking.useDHCP = false;
networking.interfaces.eth0.useDHCP = true;
time.timeZone = "America/Chicago";
i18n.defaultLocale = "en_US.UTF-8";

boot.kernel.sysctl = {
  "net.ipv6.conf.all.disable_ipv6" = 1;

  "net.ipv6.conf.default.disable_ipv6" = 1;

  "net.ipv6.conf.lo.disable_ipv6" = 1;
};

networking.nameservers = [ "192.168.130.2" "192.168.130.3" ];

networking.hosts = {
  "192.168.142.2" = [ "ra.heyjohn.family" ];
};

nix.settings.trusted-users = [ "root" "@wheel" ];

users.users.crutonjohn = {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  home = "/home/crutonjohn";
  packages = with pkgs; [
    vim
    tree
    lego
  ];
  openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3IymQJLihK5LZXw1cf4vw3X9iLyQ9qJn/RPHd4ccvTdcFGzJYiE2H62DCpZaYh/VXqAb5RziEGUkAvPncBAvFuvbzSrsGwd5D9TQwGPKIv/IB3cHSS/XhQbIb4A+UJ482LLd1hZE6Ddm6C3BQIXfEPD94+NxPHF670/BrLQkrWgt8Sd4n9lzuwE9mtOeIvcyiE4zhdDrM68tEKS5fSgrKqff7ldpCzLC6drgf3LZzi7xpGyscnNXaUD5t9yB9VyRlaF3y1FkY9GStZQ/izyH9BOfDurqtlX6YhhWd4kFDnRVPWbF3Z6wXatmhlv9IDjemhFFp3Xqh670SFT2YyRf344MhI32WjeE25aSCPZYuOAZL0TAnILlnfrOJjvSR+zpOTnpTCz8z4ReG9CoNHUNEDsdjXxqrki3Z/7sYSYLm/rUlCJREhxWbLHh7a2SOUeIUzRLlIaBUlbdPWYPyuluMe5MgctglO4Nc/IBYJb7baV/8g79tDaS4PMLIilQZ950=" ];
};

# really bad deployment tool hack
# need to limit the scope of the commands in the future
security.sudo.wheelNeedsPassword = false;

security.pki.certificates = [
  ''
    -----BEGIN CERTIFICATE-----
    MIIBlzCCAT2gAwIBAgIQUpQBQxZIqmRM7G2TXqG+6TAKBggqhkjOPQQDAjAqMSgw
    JgYDVQQDEx9oZXlqb2huLmZhbWlseSBJbnRlcm5hbCBSb290IENBMB4XDTI1MDMw
    MjA3MDE1MFoXDTM1MDIyODA3MDE1MFowKjEoMCYGA1UEAxMfaGV5am9obi5mYW1p
    bHkgSW50ZXJuYWwgUm9vdCBDQTBZMBMGByqGSM49AgEGCCqGSM49AwEHA0IABJ3X
    mNYRYbLLKbGizAKZR3lYxPqnsnXmPotYokuY+vKJ8iuc7nFbSKLbl95EKR1gMY6u
    iO9zmxqsBMGff6kvb66jRTBDMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
    AQH/AgEBMB0GA1UdDgQWBBTlfB3jEuTS6VvJdlv7ZZxrOY4fnDAKBggqhkjOPQQD
    AgNIADBFAiEAr8RV0ixLb0c2zCQeJc1SfCRDC6rhT9xWey62p+qpmzYCIBXz63ba
    tBOU7WFC8guYTAO9xMu35MnTgYD7K0OLLGvG
    -----END CERTIFICATE-----
  ''
];

# https://nixos.wiki/wiki/Fail2ban
services.fail2ban = {
  enable = true;
  maxretry = 5;
  ignoreIP = [
    "dyn4.crutonjohn.com"
    "127.0.0.1"
  ];
  bantime = "24h";
  bantime-increment = {
    enable = true;
    formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
    maxtime = "600h";
    overalljails = true;
  };
};

environment.systemPackages = with pkgs; [
  vim
  wget
  inetutils
  mtr
  sysstat
  dig
  openssl
  tcpdump
  step-cli
];

services.openssh = {
  enable = true;
  settings.PermitRootLogin = "no";
};

networking.firewall.allowedTCPPorts = [ 22 80 443 4317 4318 ];
# networking.firewall.allowedUDPPorts = [ ... ];
networking.firewall.enable = true;
networking.usePredictableInterfaceNames = false;

system.stateVersion = "23.05";
}
