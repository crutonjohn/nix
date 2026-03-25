{ ... }:
{

  imports = [
    ./binds.nix
    ./decoration.nix
    ./exec.nix
    ./general.nix
    ./gestures.nix
    ./input.nix
    ./layout.nix
    ./misc.nix
    # disabled for kanshi (docked/mobile)
    #./monitor.nix
    ./plugins.nix
    ./raw.nix
    ./scripts.nix
    ./windowrules.nix
    ./workspaces.nix
  ];

}
