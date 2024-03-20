{ config, lib, pkgs, ... }: {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza";
      k = "kubecolor";
      kk = "kubectl";
    };
    functions = {
      yy = ''
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
  };
  programs.fzf.enableFishIntegration = true;

}
