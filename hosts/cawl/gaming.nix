{ inputs, ... }:

{

  imports = [ inputs.play-nix.nixosModules.play ];

  play = {
    amd.enable = false; # AMD GPU optimization
  };
}
