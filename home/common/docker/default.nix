{ pkgs, inputs, ... }:
{

  imports = [
  ];

  home = {
    packages = with pkgs; [
      containerd
      docker
      docker-compose
      lazydocker
      inputs.compose2nix.packages.x86_64-linux.default
    ];
  };

}
