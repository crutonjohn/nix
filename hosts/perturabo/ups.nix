{ config, ... }:

{

  sops = {
    secrets = {
      "ups/nut_admin_password" = {
        mode = "0660";
        group = "nutmon";
        owner = "nutmon";
        restartUnits = [
          "upsd.service"
          "upsmon.service"
        ];
      };
      "ups/nut_exporter_password" = {
        mode = "0660";
        group = "nutmon";
        owner = "nutmon";
        restartUnits = [
          "upsd.service"
          "upsmon.service"
        ];
      };
    };
  };

  power.ups = {
    enable = true;
    mode = "standalone";
    ups."garage" = {
      port = "auto";
      driver = "usbhid-ups";
      description = "Cyber Power System, Inc. CP1500 AVR UPS";
      directives = [
        # "Restore power on AC" BIOS option needs power to be cut a few seconds to work;
        # this is achieved by the offdelay and ondelay directives.

        # in the last stages of system shutdown, "upsdrvctl shutdown" is called to tell UPS that
        # after offdelay seconds, the UPS power must be cut, even if
        # wall power returns.

        # There is a danger that the system will take longer than the default 20 seconds to shut down.
        # If that were to happen, the UPS shutdown would provoke a brutal system crash.
        # We adjust offdelay, to solve this issue.
        "offdelay = 60"

        # UPS power is now cut regardless of wall power.  After (ondelay minus offdelay) seconds,
        # if wall power returns, turn on UPS power.  The system has now been disconnected for a minimum of (ondelay minus offdelay) seconds,
        # "Restore power on AC" should now power on the system.
        # For reasons described above, ondelay value must be larger than offdelay value.
        # We adjust ondelay, to ensure Restore power on AC option returns to Power Disconnected state.
        "ondelay = 70"

        # set value for battery.charge.low,
        # upsmon initiate shutdown once this threshold is reached.
        "lowbatt = 30"

        # ignore it if the UPS reports a low battery condition
        # without this, system will shutdown only when ups reports lb,
        # not respecting lowbatt option
        "ignorelb"
      ];
    };
    upsd = {
      listen = [
        {
          address = "127.0.0.1";
          port = 3493;
        }
      ];
    };
    users."nut-admin" = {
      # A file that contains just the password.
      passwordFile = "/run/secrets/ups/nut_admin_password";
      upsmon = "primary";
    };
    upsmon.monitor."garage" = {
      system = "garage@localhost";
      powerValue = 1;
      user = "nut-admin";
      passwordFile = "/run/secrets/ups/nut_admin_password";
      type = "primary";
    };
  };

  power.ups.users."nut-exporter" = {
    passwordFile = "/run/secrets/ups/nut_exporter_password";
    upsmon = "secondary";
  };

  services.prometheus.exporters.nut = {
    enable = true;
    openFirewall = true;
    port = 9199;
    user = "nutmon";
    nutUser = "nut-exporter";
    passwordPath = config.power.ups.users."nut-exporter".passwordFile;
  };

}
