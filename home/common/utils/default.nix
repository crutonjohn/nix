{ pkgs, ... }:
{

  imports = [
  ];

  home = {
    packages = with pkgs; [
      awscli2
      asciinema
      bitwarden-cli
      cz-cli
      dig
      figlet
      fish
      file
      ffmpeg
      gawk
      go
      htop
      jq
      mlocate
      openssl
      rclone
      ripgrep
      screen
      socat
      sqlite
      terraform
      tree
      unzip
      watchexec
      whois
      wget
      dyff
      traceroute
      p7zip
      rar
      appimage-run
      brightnessctl
      catimg
      catt
      ceph
      comma
      gettext
      lapce
      libgcc
      libinput
      libnotify
      neofetch
      networkmanager
      nfs-utils
      nmap
      pixman
      powertop
      psmisc
      tailscale
      termshark
      tlp
      unixtools.procps
      wev
    ];
  };

}
