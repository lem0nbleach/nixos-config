{
  lib,
  pkgs,
  ...
}:

let
  user = "lem0nbleach";
  shutdownTime = "22:30";
  warnFrom = "22:00";
  runtimeDir = "/run/user/1000";

  bedtime = pkgs.writeShellApplication {
    name = "anchovy-bedtime";
    runtimeInputs = with pkgs; [
      coreutils
      findutils
      hyprland
      systemd
      util-linux
    ];
    text = ''
      set -eu

      user="${user}"
      runtime="${runtimeDir}"
      dry_run=0
      if [ "''${1:-}" = "--dry-run" ]; then
        dry_run=1
      fi

      notify() {
        local message="$1"
        local signature
        signature="$(find "$runtime/hypr" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | head -n 1 || true)"
        if [ -z "$signature" ]; then
          logger -t anchovy-bedtime "no Hyprland session, notification skipped: $message"
          return 0
        fi
        if runuser -u "$user" -- env \
          XDG_RUNTIME_DIR="$runtime" \
          HYPRLAND_INSTANCE_SIGNATURE="$signature" \
          hyprctl notify -1 15000 "rgb(ffb300)" "$message" \
          >/dev/null 2>&1; then
          logger -t anchovy-bedtime "notification sent: $message"
        else
          logger -t anchovy-bedtime "hyprctl notify failed: $message"
        fi
      }

      seconds_until() {
        local target
        target="$(date -d "$1" +%s)"
        local now
        now="$(date +%s)"
        local delta=$((target - now))
        if [ "$delta" -lt 0 ]; then
          delta=0
        fi
        echo "$delta"
      }

      if [ "$dry_run" -eq 1 ]; then
        notify "Anchovy shuts down in 30 minutes (dry run)"
        sleep 5
        notify "Anchovy shuts down in 5 minutes (dry run)"
        sleep 3
        notify "Anchovy shuts down in 1 minute (dry run)"
        logger -t anchovy-bedtime "dry run complete, shutdown not scheduled"
        exit 0
      fi

      notify "Anchovy shuts down in 30 minutes (22:30) - run bedtime cancel to stay on"
      shutdown -h "${shutdownTime}"

      sleep "$(seconds_until "22:25")"
      notify "Anchovy shuts down in 5 minutes"

      sleep "$(seconds_until "22:29")"
      notify "Anchovy shuts down in 1 minute"

      logger -t anchovy-bedtime "warnings delivered, shutdown at ${shutdownTime} is scheduled"
    '';
  };

  bedtimeCancel = pkgs.writeShellApplication {
    name = "bedtime-cancel";
    runtimeInputs = with pkgs; [
      coreutils
      systemd
      util-linux
    ];
    text = ''
      set -eu

      systemctl stop anchovy-bedtime.service || true

      if shutdown -c; then
        logger -t anchovy-bedtime "scheduled shutdown cancelled by ''${SUDO_USER:-unknown}"
        echo "Bedtime cancelled for tonight. Warnings return tomorrow at ${warnFrom}."
      else
        logger -t anchovy-bedtime "no scheduled shutdown to cancel"
        echo "No shutdown was scheduled. Warnings still run tomorrow at ${warnFrom}."
      fi
    '';
  };

  bedtimeCli = pkgs.writeShellApplication {
    name = "bedtime";
    runtimeInputs = with pkgs; [
      coreutils
      systemd
    ];
    text = ''
      set -eu

      case "''${1:-status}" in
        cancel|off)
          sudo -n ${bedtimeCancel}/bin/bedtime-cancel || {
            echo "bedtime-cancel needs its NOPASSWD rule; apply the config with nh os switch." >&2
            exit 1
          }
          ;;
        test)
          sudo -n ${bedtime}/bin/anchovy-bedtime --dry-run || {
            echo "Dry run needs its NOPASSWD rule; apply the config with nh os switch." >&2
            exit 1
          }
          ;;
        status)
          if systemctl is-active --quiet anchovy-bedtime.service; then
            echo "service: running (warnings in progress)"
          else
            echo "service: idle"
          fi
          if [ -f /run/systemd/shutdown/scheduled ]; then
            echo "pending shutdown:"
            cat /run/systemd/shutdown/scheduled
          else
            echo "pending shutdown: none"
          fi
          echo "timer:"
          systemctl list-timers --no-pager anchovy-bedtime.timer | head -n 2 || true
          ;;
        *)
          echo "usage: bedtime [status|cancel|test]" >&2
          exit 2
          ;;
      esac
    '';
  };
in
{
  environment.systemPackages = [ bedtimeCli ];

  systemd.services.anchovy-bedtime = {
    description = "Warn about the nightly ${shutdownTime} shutdown";
    serviceConfig = {
      Type = "simple";
      ExecStart = lib.getExe bedtime;
      Restart = "no";
    };
  };

  systemd.timers.anchovy-bedtime = {
    description = "Start the bedtime warnings at ${warnFrom}";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* ${warnFrom}:00";
      AccuracySec = "1s";
      WakeSystem = true;
      Persistent = false;
      Unit = "anchovy-bedtime.service";
    };
  };

  security.sudo.extraRules = [
    {
      users = [ user ];
      commands = [
        {
          command = "${bedtimeCancel}/bin/bedtime-cancel";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${bedtime}/bin/anchovy-bedtime --dry-run";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
