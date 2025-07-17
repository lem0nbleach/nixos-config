{ lib, config, pkgs, ... }:
let
  hostname = config.networking.hostName;
in
lib.mkMerge [
  {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    services.xserver.displayManager.lightdm.enable = false;
    programs.hyprlock.enable = true;
    programs.uwsm.enable = true;
    services.displayManager.defaultSession = "hyprland-uwsm";
  }
  (lib.mkIf (hostname == "anchovy") {
    services.fprintd.enable = true;
    security.pam.services.hyprlock.fprintAuth = true;
    services.logind.lidSwitch = "suspend";
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/leds/%k/brightness"
      ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
    '';
  })
]
