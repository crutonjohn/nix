{ config, pkgs, ... }: {
  programs.fish = {
    functions = {
      nrb = "home-manager switch --flake github:crutonjohn/nix#bjohn@work";
    };
  };
}
