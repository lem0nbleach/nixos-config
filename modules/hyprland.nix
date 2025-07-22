{ lib, config, pkgs, inputs, ... }:

let
  hyprsunsetScript = pkgs.writeShellApplication {
    name = "sunset-checker";
    runtimeInputs = [ pkgs.hyprland pkgs.procps ];
    text = ''
      # Get current time in minutes
      current_hour=$(date +%H)
      current_minute=$(date +%M)
      current_time_minutes=$((current_hour * 60 + current_minute))

      # Convert times to minutes by Hours*60 + Minutes
      evening_start=1200  # 8:00 PM
      morning_end=270     # 4:30 AM

      if [[ "$current_time_minutes" -ge "$evening_start" ]] || [[ "$current_time_minutes" -le "$morning_end" ]]; then
        echo "Changing to nighttime hyprsunset"
        hyprctl hyprsunset temperature 4500
      else
        echo "Changing to default hyprsunset"
        hyprctl hyprsunset identity
      fi
    '';
  };

in
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
        ExecStart = lib.getExe hyprsunsetScript;
      };
    };
    systemd.user.timers.hyprsunset = {
      description = "Run hyprsunset check every minute";
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      timerConfig = {
        AccuracySec = "1s";
        OnCalendar = "*:0/1";  # Every minute
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
