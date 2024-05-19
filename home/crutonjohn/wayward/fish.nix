{ config, pkgs, ... }: {
  programs.fish = {
    functions = {
      nrb = "sudo nixos-rebuild switch --flake github:crutonjohn/nix#wayward --option tarball-ttl 0";
      nrbu = "sudo nixos-rebuild switch --upgrade --flake github:crutonjohn/nix#wayward --option tarball-ttl 0";
      nrbl = "sudo nixos-rebuild switch --flake /home/crutonjohn/nix#wayward'";
    };
  };
}
