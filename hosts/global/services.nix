{ ... }:

{

  services = {
    journald = {
      extraConfig = ''
        SystemMaxUse=1G
        RuntimeMaxUse=256M
        MaxRetentionSec=14day
      '';
    };
  };

}
