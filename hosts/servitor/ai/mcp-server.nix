{ config, pkgs, inputs, lib, ... }:

{

  environment = {
    systemPackages = with pkgs; [
      python312
      python312Packages.virtualenv
      git
      python312Packages.uv
      nodejs_24
    ];
  };

  systemd.services."ollama-mcpo" = {
      description = "Transparent bridge to enable MCP on ollama";
      path = [
        "/run/current-system/sw/bin"
        "/run/wrappers/bin"
        "/root/.nix-profile/bin"
        "/nix/profile/bin"
        "/root/.local/state/nix/profile/bin"
        "/etc/profiles/per-user/root/bin"
        "/nix/var/nix/profiles/default/bin"
      ];
      script = ''
        PATH=$PATH:/run/current-system/sw/bin:/run/wrappers/bin:/root/.nix-profile/bin:/nix/profile/bin:/root/.local/state/nix/profile/bin:/etc/profiles/per-user/root/bin:/nix/var/nix/profiles/default/bin
        uv run --directory /srv/mcpo \
        mcpo \
          --config /srv/mcpo/config/mcp-config.json \
          --hot-reload
      '';
      wantedBy = ["ollama.service"];
      reloadIfChanged = true;
    };
}
