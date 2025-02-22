{ config, pkgs, ... }:

{
  # Enable the NFS server service
  services.nfs.server = {
    enable = true;
    # Configure the shares
    exports = [
      "/mnt/apollo/games/ark *(rw,sync,no_subtree_check)"
    ];
  };

# Set up the directories for the shares
#  environment.etc."exports" = {
#    text = ''
#      /srv/nfs/share1 *(rw,sync,no_subtree_check)
#      /srv/nfs/share2 *(rw,sync,no_subtree_check)
#    '';
#  };

  # Enable portmap for NFS to work properly
  services.rpcbind.enable = true;
}

