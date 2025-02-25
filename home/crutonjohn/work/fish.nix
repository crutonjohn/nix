{ config, pkgs, ... }: {
  programs.fish = {
    functions = {
      nrb = "home-manager switch --flake github:crutonjohn/nix#bjohn@work";
    };
    shellInit = ''
      fish_add_path $HOME/.local/share/gem/ruby/3.0.0/bin
    '';
  };
}
