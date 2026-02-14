{ pkgs, ... }:
{

  imports = [
    ../global
    ./otelcol.nix
    ./loki
    ./grafana
    ./prometheus
    ./blog.nix
    ./hardware-configuration.nix
    ./headscale.nix
    ./nginx.nix
    ./sops.nix
    ./tailscale.nix
    ./teamspeak.nix
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

  networking.nameservers = [
    "192.168.130.2"
    "192.168.130.3"
  ];

  networking.hosts = {
    "192.168.142.2" = [ "ra.heyjohn.family" ];
  };

  # really bad deployment tool hack
  # need to limit the scope of the commands in the future
  # security.sudo.wheelNeedsPassword = false;

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

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    4317
    4318
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  networking.usePredictableInterfaceNames = false;

  system.stateVersion = "25.11";
}
