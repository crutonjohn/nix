{ ... }:

{
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/apollo/games/ark *(rw,sync,no_subtree_check)
      /mnt/apollo/games/ark/backups *(rw,sync,no_subtree_check)
    '';
  };

  services.rpcbind.enable = true;
}
