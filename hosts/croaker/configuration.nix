{ config, pkgs, pkgsStable, inputs, lib, ... }:

{
  imports =
    [
      ./modules
      ../../config/croaker.nix
      ../../modules
    ];

  config = {
    croaker = true;
    
    networking.hostName = "croaker";

    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    users.users.lem0nbleach = {
      isNormalUser = true;
      description = "It's me aye";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    system.stateVersion = "24.05";

    environment.sessionVariables = {
      TERM = "foot";
      BROWSER = "firefox";
      TERMINAL = "foot";
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GTK_USE_PORTAL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      EDITOR = "hx";
      PROTON_VERSION = "GE-Proton9-18";
    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
