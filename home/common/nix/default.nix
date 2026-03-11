{ pkgs, ... }:
{

  imports = [
    ./scripts.nix
  ];

  home = {
    packages = with pkgs; [
      cachix
      nix-index
      nixfmt
      # nil -- installed via flake
      inputs.nil.packages.x86_64-linux.default
      nixd
    ];
  };

}
