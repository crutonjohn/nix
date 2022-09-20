{ config, pkgs, ... }:

{

# NetworkManager
networking.networkmanager.enable = true;

# Enable the OpenSSH daemon.
services.openssh.enable = true;

# Touchpad support
services.xserver.libinput.enable = true;
services.xserver.libinput.touchpad.tapping = false;

# Enable CUPS to print documents.
services.printing.enable = true;

# Bluetooth
hardware.bluetooth.enable = true;

}
