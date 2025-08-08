{ config, lib, pkgs, inputs, outputs, ... }: {

  imports = [
    ../common
    ./programs
    ./git.nix
    ./scripts.nix
  ];

  home.username = "crutonjohn";
  home.homeDirectory = "/home/crutonjohn";

  home.packages = with pkgs; [
    appimage-run
    at-spi2-atk
    catimg
    catt
    ceph
    comma
    dmenu
    docker
    docker-compose
    gettext
    helvum
    hexchat
    inputs.compose2nix.packages.x86_64-linux.default
    jdk11
    lapce
    libgcc
    libinput
    libnotify
    mqttui
    neofetch
    networkmanager
    networkmanager_dmenu
    nfs-utils
    nil
    nmap
    powertop
    psmisc
    qemu
    step-cli
    tailscale
    termshark
    tlp
    unixtools.procps
    volctl
    zeal
    zlib
  ];

}
