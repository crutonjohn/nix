{ ... }:

{
  # Libvirt
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Podman
  virtualisation.podman.enable = true;

  # Docker
  virtualisation.docker.enable = true;
}
