{ config, pkgs, ... }: {
  programs.fish = {
    functions = {
      nrb = "sudo nixos-rebuild switch --flake github:crutonjohn/nix#wayward";
      nrbu = "sudo nixos-rebuild switch --upgrade --flake github:crutonjohn/nix#wayward";
    };
  };
}
