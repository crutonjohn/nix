{ ... }:
{

  programs.fish = {
    functions = {
      nrb = ''
        set system $argv
        nixos-rebuild switch --sudo --ask-sudo-password --build-host $system --target-host $system --flake github:crutonjohn/nix#$system --option tarball-ttl 0
      '';
      nrl = ''
        sudo nixos-rebuild switch --flake .#$hostname
      '';
      nrbuild = ''
        set system $argv
        nixos-rebuild build --flake github:crutonjohn/nix#$system --option tarball-ttl 0
      '';
      nrbu = ''
        set system $argv
        nixos-rebuild switch --sudo --ask-sudo-password --upgrade --build-host $system --target-host $system --flake github:crutonjohn/nix#$system --option tarball-ttl 0
      '';
    };
  };

}
