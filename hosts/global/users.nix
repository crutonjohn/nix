{ pkgs, ... }:

{

  users.defaultUserShell = pkgs.bashInteractive;

  users.users = {
    crutonjohn = {
      description = "Curtis Ray John";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "dialout"
        "wireshark"
        "libvirtd"
      ];
      isNormalUser = true;
      home = "/home/crutonjohn";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3IymQJLihK5LZXw1cf4vw3X9iLyQ9qJn/RPHd4ccvTdcFGzJYiE2H62DCpZaYh/VXqAb5RziEGUkAvPncBAvFuvbzSrsGwd5D9TQwGPKIv/IB3cHSS/XhQbIb4A+UJ482LLd1hZE6Ddm6C3BQIXfEPD94+NxPHF670/BrLQkrWgt8Sd4n9lzuwE9mtOeIvcyiE4zhdDrM68tEKS5fSgrKqff7ldpCzLC6drgf3LZzi7xpGyscnNXaUD5t9yB9VyRlaF3y1FkY9GStZQ/izyH9BOfDurqtlX6YhhWd4kFDnRVPWbF3Z6wXatmhlv9IDjemhFFp3Xqh670SFT2YyRf344MhI32WjeE25aSCPZYuOAZL0TAnILlnfrOJjvSR+zpOTnpTCz8z4ReG9CoNHUNEDsdjXxqrki3Z/7sYSYLm/rUlCJREhxWbLHh7a2SOUeIUzRLlIaBUlbdPWYPyuluMe5MgctglO4Nc/IBYJb7baV/8g79tDaS4PMLIilQZ950="
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf17GcWtY5nlZ8gMCHAFDqXaMZ1Tg4j18TCp4B8fdAoMKc5Q0ygVlBz+O8nakIqJRsVMi4tfD3eQjGH28UJOeTGU9F5z2ztlbd/oH/Z39QPK+u03+zsFHxE8El5vtv6PGW7YNcT2S449QbEDs9pLZKmvyTDkwdUyrcbJzQy4OFBFUaGSgCSCPZcRSn0gDWKDeAxS9W84VJeNHEtRSCd3H3KyJdIqSkopUDokxou7H+jGceyEGaNdEI+fw69oYcQB28VAOSgUe8AIcs7Jd7iN6ExlzfWmpdeyeTRmYs0K4kgL3h8JHiJkd3XdlDzFVIKP26oTbEmYd/jVOTuRdsunJp"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK1AE5OJ9NDmob6zeBlH02aBeExtVxMhrBjxo9hB2Pjw"
      ];
    };
    root = {
      shell = pkgs.bashInteractive;
    };
  };

  security.sudo.extraRules = [
    {
      users = [ "crutonjohn" ];
      commands = [
        {
          command = "${pkgs.systemd}/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/reboot";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.systemd}/bin/poweroff";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [
            "SETENV"
            "NOPASSWD"
          ];
        }
      ];
    }
  ];

}
