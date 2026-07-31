{
  lib,
  config,
  pkgs,
  ...
}:

let
  # To check for the battery level on Anchovy and notify when it is low 
  battery-notification = pkgs.writeShellApplication {
    name = "battery-notification";
    runtimeInputs = [ pkgs.libnotify ];
    text = ''
      battery=$(cat /sys/class/power_supply/BAT1/capacity)
      flag="/tmp/battery_alerts"
      mkdir -p "$flag"

      if [[ "$battery" -le 10 ]] && [[ "$battery" -gt 5 ]]; then
        if [[ ! -f "$flag/battery_low_sent" ]]; then 
          notify-send "Battery Low: Less Than 10%"
          touch "$flag/battery_low_sent"
          rm -f "$flag/battery_critical_sent"
        fi
      elif [[ "$battery" -le 5 ]]; then
        if [[ ! -f "$flag/battery_critical_sent" ]]; then
          notify-send "Battery Critical: Less Than 5%"
          touch "$flag/battery_critical_sent"
          # not remvoing the low flag to prevent duplicate
          # notification when recharged to 10%
          # rm -f "$flag/battery_low_sent"
        fi
      else
        rm -f "$flag/battery_low_sent" "$flag/battery_critical_sent"
      fi
    '';
  };

in
lib.mkIf config.anchovy {
  systemd.user.services.battery-notification = {
    description = "Check for low battery level and notify";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe battery-notification;
    };
  };
  systemd.user.timers.battery-notification = {
    description = "Run battery check every minute";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    timerConfig = {
      AccuracySec = "1s";
      OnCalendar = "*:0/1";
    };
  };
}
