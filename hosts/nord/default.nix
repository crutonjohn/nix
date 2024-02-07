{ name, nodes, pkgs, lib, inputs, ... }: {

deployment = {
  targetHost = "nord";
  targetPort = 22;
  targetUser = "crutonjohn";
  buildOnTarget = true;
};

imports =
  [
    ./hardware-configuration.nix
    ./blog.nix
    ./headscale.nix
    ./sops.nix
  ];

boot.loader.grub.enable = true;
networking.hostName = "nixos-us-ord"; # Define your hostname.
networking.useDHCP = false;
networking.interfaces.eth0.useDHCP = true;
time.timeZone = "America/Chicago";
i18n.defaultLocale = "en_US.UTF-8";

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
];

services.openssh = {
  enable = true;
  settings.PermitRootLogin = "no";
};

networking.firewall.allowedTCPPorts = [ 22 80 443 ];
# networking.firewall.allowedUDPPorts = [ ... ];
networking.firewall.enable = true;
networking.usePredictableInterfaceNames = false;

system.stateVersion = "23.05";
}
