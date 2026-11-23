{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  stashPKG = inputs.stash.packages.x86_64-linux.default;
  # Use nixpkgs' hyprshutdown/hyprlauncher/quickshell: the pinned nixpkgs revision
  # cannot build the git versions' hyprtoolkit -> hyprlang chain (libstdc++ ABI
  # mismatch in hyprlang-0.6.8's fuzz test link).
  hyprshutdownPKG = pkgs.hyprshutdown;
  hyprqt6enginePKG = inputs.hyprqt6engine.packages.x86_64-linux.default;
  hyprlauncherPKG = pkgs.hyprlauncher;
  quickshellPKG = pkgs.quickshell;
  hyprsunsetScript = pkgs.writeShellApplication {
    name = "sunset-checker";
    runtimeInputs = [
      pkgs.hyprland
      pkgs.procps
    ];
    text = ''
      # Get current time in minutes
      current_hour=$(date +%H)
      current_minute=$(date +%M)
      current_time_minutes=$((current_hour * 60 + current_minute))

      # Convert times to minutes by Hours*60 + Minutes
      evening_start=1200  # 8:00 PM
      morning_end=270     # 4:30 AM

      if [[ "$current_time_minutes" -ge "$evening_start" ]] || [[ "$current_time_minutes" -le "$morning_end" ]]; then
        echo "Changing to night time hyprsunset"
        hyprctl hyprsunset temperature 3400
      else
        echo "Changing to default hyprsunset"
        hyprctl hyprsunset identity
      fi
    '';
  };

in
lib.mkMerge [
  {
    programs.hyprland = {
      enable = true;
      # Hyprland starts hyprland-session.target / graphical-session.target itself;
      # UWSM is no longer needed (and upstream calls it a niche, quirky path).
      withUWSM = false;
    };
    programs.hyprlock.enable = true;

    services.playerctld.enable = true;

    services.elephant.enable = true;

    # sway.nix pins common.default to the wlr portal; give Hyprland its own
    # section so screen sharing / screencopy uses xdg-desktop-portal-hyprland.
    xdg.portal.config.hyprland = {
      default = [
        "hyprland"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };

    # ly enumerates every .desktop in the aggregated session directory. The
    # Hyprland package ships an "uwsm-managed" entry that is dead here because
    # uwsm is not installed; hand ly a filtered directory instead.
    services.displayManager.ly.settings.waylandsessions =
      let
        desktops = config.services.displayManager.sessionData.desktops;
        lySessions = pkgs.runCommand "ly-wayland-sessions" { } ''
        mkdir -p $out/share/wayland-sessions
        n=0
        for f in ${desktops}/share/wayland-sessions/*.desktop; do
          case "$f" in
            *hyprland-uwsm.desktop) continue ;;
          esac
          # copy through symlinks: ly's crawl opens each entry directly and a
          # broken/relocated link silently empties the whole session list
          cp -Lf "$f" $out/share/wayland-sessions/ && n=$((n + 1))
        done
        if [ "$n" -lt 2 ]; then
          echo "ly-wayland-sessions: only $n session entries, refusing" >&2
          exit 1
        fi
        '';
      in
      "${lySessions}/share/wayland-sessions";

    environment.systemPackages = [
      hyprqt6enginePKG
      hyprlauncherPKG
      hyprshutdownPKG
      quickshellPKG
      pkgs.hyprpaper
      pkgs.hyprcursor
      pkgs.hyprsunset
      pkgs.walker
      pkgs.grim
      pkgs.slurp
      pkgs.wluma
      pkgs.mako
      pkgs.brightnessctl
      stashPKG
      # for the systemd service below
      pkgs.killall
    ];

    # Hyprland 0.55.4 ships no session unit and does not start
    # graphical-session.target itself (that landed later upstream). Recreate the
    # documented hyprland-session.target so graphical-session.target is started
    # as a dependency (it refuses manual starts), pulling in hypridle,
    # elephant, wluma and the hyprsunset timer.
    systemd.user.targets.hyprland-session = {
      description = "Hyprland compositor session";
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
    };

    systemd.user.services.hyprshutdown = {
      description = "hyprshutdown before poweroff for graceful shutdown";
      serviceConfig = {
        Type = "oneshot";
        ExecStop = lib.getExe hyprshutdownPKG;
        RemainAfterExit = true;
      };
      wantedBy = [ "multi-user.target" ];
    };
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
        OnCalendar = "*:0/1"; # Every minute
      };
    };
  }

  (lib.mkIf config.anchovy {
    services.fprintd.enable = true;
    security.pam.services.hyprlock.fprintAuth = true;
    services.logind.settings.Login = {
      HandleLidSwitch = "lock";
      KillUserProcesses = false;
    };
    systemd.services.kill-printd = {
      description = "Kill fprintd before sleep";
      before = [ "sleep.target" ];
      wantedBy = [ "sleep.target" ];
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.killall} fprintd";
      };
    };

    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/leds/%k/brightness"
      ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
    '';
  })
]
