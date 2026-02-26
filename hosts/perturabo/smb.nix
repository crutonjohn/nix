{ config, pkgs, ... }:

{

  users.groups.talos = { };
  users.users = {
    talos = {
      description = "Talos K8s Service Account";
      shell = pkgs.bash;
      group = "talos";
      isSystemUser = true;
      home = "/home/talos";
    };
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = config.networking.hostName;
        "netbios name" = config.networking.hostName;
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.130.1/24 192.168.128.1/24 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      };
      "videos" = {
        "path" = "/mnt/olympia/videos";
        "valid users" = "crutonjohn talos";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "crutonjohn";
        "force group" = "users";
      };
      "music" = {
        "path" = "/mnt/olympia/music";
        "valid users" = "crutonjohn talos";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "root";
        "force group" = "users";
      };
      "audiobooks" = {
        "path" = "/mnt/olympia/audiobooks";
        "valid users" = "crutonjohn talos";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "root";
        "force group" = "users";
      };
      "ebooks" = {
        "path" = "/mnt/olympia/ebooks";
        "valid users" = "crutonjohn talos";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "root";
        "force group" = "users";
      };
      "root" = {
        "path" = "/mnt/olympia";
        "valid users" = "crutonjohn";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "root";
        "force group" = "users";
      };
      "apollo" = {
        "path" = "/mnt/apollo";
        "valid users" = "crutonjohn";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "root";
        "force group" = "users";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  #networking.firewall.enable = true;
  networking.firewall.allowPing = true;

}
