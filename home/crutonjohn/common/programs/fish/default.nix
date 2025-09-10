{ pkgs, ... }: {

  imports = [ ./greeter.nix ];

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      k = "kubecolor";
      kk = "kubectl";
    };
    functions = {
      yy = ''
        set tmp (mktemp -p /tmp/yazi)
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
      ".." = ''
        if test -z $argv[1]
          set n 1
        else
          set n $argv[1]
        end
        for i in (seq $n)
          cd ..
        end
      '';
    };
    plugins = [
      {
        name = "fish-kubectl-completions";
        src = pkgs.fetchFromGitHub {
          owner = "evanlucas";
          repo = "fish-kubectl-completions";
          rev = "ced676392575d618d8b80b3895cdc3159be3f628";
          sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
        };
      }

      {
        name = "ev-fish";
        src = pkgs.fetchFromGitHub {
          owner = "joehillen";
          repo = "ev-fish";
          rev = "a3d0658c5e0563ff0f4ade9e83b20e01fea0a9e6";
          sha256 = "sha256-t7FKKzD42hAZV7CpitrznRYLkCYok7Bqg1JXW7BaKyA=";
        };
      }
    ];
  };

}
