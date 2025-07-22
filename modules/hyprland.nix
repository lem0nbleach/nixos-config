{ lib, config, pkgs, inputs, ... }:

lib.mkMerge [
  (lib.mkIf (config.anchovy || config.croaker) {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    programs.hyprlock.enable = true;
    programs.uwsm.enable = true;
    services.displayManager.defaultSession = "hyprland-uwsm";
    # Let lem0nbleach automatically be loggedin at boot up
    services.getty.autologinUser = "lem0nbleach";
    services.playerctld.enable = true;

    environment.systemPackages = [
      pkgs.hyprpaper
      pkgs.hyprcursor
      pkgs.hyprsunset
      pkgs.walker
      pkgs.grim
      pkgs.slurp
      pkgs.wluma
      pkgs.mako
      pkgs.brightnessctl
      pkgs.wl-clipboard
      inputs.quickshell.packages.x86_64-linux.default
    ];

    programs.bash.loginShellInit = ''
  		if uwsm check may-start; then
      	exec uwsm start hyprland-uwsm.desktop
  	  fi
    '';

    systemd.user.services.hyprsunset = {
      description = "Run hyprsunset check";
      serviceConfig = {
        Type = "oneshot";
        ExecStart ="${pkgs.bash}/bin/bash /home/lem0nbleach/nixos/modules/scripts/auto-sunset.sh";
      };
      path = [
        pkgs.hyprsunset
        pkgs.procps
      ];
    };
    systemd.user.timers.hyprsunset = {
      description = "Run hyprsunset check every minute";
      wantedBy = [ "timers.target" ];
      after = [ "graphical-session.target" ];
      timerConfig = {
        OnCalendar = "*:0/1";  # Every minute
        Persistent = true;
      };
    };
  })

  (lib.mkIf config.anchovy {
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
