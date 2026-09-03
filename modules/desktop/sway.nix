{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf (config.croaker || config.anchovy) {
  environment.systemPackages = [
    pkgs.wl-clipboard
    pkgs.mako
    pkgs.slurp
    pkgs.grim
    pkgs.wluma
  ];

  services.gnome.gnome-keyring.enable = true;
  services.dbus.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.displayManager.ly.enable = true;

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    GTK_USE_PORTAL_FILE_CHOOSER = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd = "${lib.getExe pkgs.slurp} -f 'Monitor: %o' -or";
        };
      };
    };
    config = {
      common = {
        default = [
          "wlr"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      sway = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };

  # Wluma

  systemd.user.services.wluma = {
    description = "Adjusting screen brightness based on screen contents and amount of ambient light";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = lib.getExe pkgs.wluma;
      Restart = "always";
      RestartSec = "5s";
      EnvironmentFile = "-%E/wluma/service.conf";
      PrivateNetwork = "true";
      PrivateMounts = "false";
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/leds/%k/brightness"
    ACTION=="add", SUBSYSTEM=="leds", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness"
  '';
}
