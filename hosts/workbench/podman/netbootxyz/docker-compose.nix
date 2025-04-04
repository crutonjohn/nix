# Auto-generated using compose2nix v0.3.0.
{ pkgs, lib, ... }:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."netbootxyz" = {
    image = "ghcr.io/netbootxyz/netbootxyz:0.7.3-nbxyz1@sha256:8dbca4d24354fd6ace12b9970188c866341384df2925753c807e87da83587438";
    environment = {
      "MENU_VERSION" = "2.0.83";
      "NGINX_PORT" = "80";
      "WEB_APP_PORT" = "3000";
    };
    volumes = [
      "/WD-RD0E4NHE/netbootxyz/assets:/assets:rw"
      "/WD-RD0E4NHE/netbootxyz/config:/config:rw"
    ];
    ports = [
      "127.0.0.1:3000:3000/tcp"
      "69:69/udp"
      "127.0.0.1:8080:80/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--hostname=netbootxyz"
      "--network-alias=netbootxyz"
      "--network=netboot_default"
    ];
  };
  systemd.services."podman-netbootxyz" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-netboot_default.service"
    ];
    requires = [
      "podman-network-netboot_default.service"
    ];
    partOf = [
      "podman-compose-netboot-root.target"
    ];
    wantedBy = [
      "podman-compose-netboot-root.target"
    ];
    unitConfig.RequiresMountsFor = [
      "/WD-RD0E4NHE/netbootxyz/assets"
      "/WD-RD0E4NHE/netbootxyz/config"
    ];
  };

  # Networks
  systemd.services."podman-network-netboot_default" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f netboot_default";
    };
    script = ''
      podman network inspect netboot_default || podman network create netboot_default
    '';
    partOf = [ "podman-compose-netboot-root.target" ];
    wantedBy = [ "podman-compose-netboot-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-netboot-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
