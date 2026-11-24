{ config, lib, pkgs, ... }:

lib.mkIf config.anchovy {
  services.fprintd.enable = true;
  security.pam.services.swaylock.fprintAuth = true;

  # Closing the lid must actually suspend. It used to be "lock", which logind
  # only turns into a lock-session request; with no locker installed that was a
  # no-op, so the laptop stayed awake with the session open.
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
    HandleSuspendKey = "suspend";
    KillUserProcesses = false;
  };

  systemd.services.kill-fprintd = {
    description = "Kill fprintd before sleep";
    before = [ "sleep.target" ];
    wantedBy = [ "sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.killall} fprintd";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/leds/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
  '';
}
