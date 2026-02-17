{ ... }:

{
  power.ups = {
    enable = true;
    mode = "standalone";
    ups."garage" = {
      port = "/dev/usb/hiddev0";
      driver = "usbhid-ups";
      description = "Garage UPS";
    };
  };
}
