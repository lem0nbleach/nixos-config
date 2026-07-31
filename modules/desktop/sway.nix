{ config, pkgs, lib, ... }:

lib.mkIf config.croaker {
  environment.systemPackages = [
    pkgs.wl-clipboard 
    pkgs.mako
    pkgs.slurp
    pkgs.grim
  ];

  services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  xdg.portal = {
    enable = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd = "${lib.getExe pkgs.slurp} -f 'Monitor: %o' -or";
        };
      };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  services.displayManager.ly.enable = true;
}
