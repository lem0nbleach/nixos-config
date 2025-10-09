{ config, pkgs, pkgsStable, inputs, lib, ... }:

{
  imports =
    [
      ../../config/croaker.nix
      ../../modules
      ./packages.nix
      ./hardware-configuration.nix
    ];

  config = {
    croaker = true;

    boot = {
      loader.efi.canTouchEfiVariables = true;

      kernel.sysctl = { "kernel.split_lock_mitigate" = 0; };

      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
    
    networking.hostName = "croaker";

    networking.networkmanager.enable = true;

    networking.interfaces.enp8s0.wakeOnLan.enable = true;

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
      BROWSER = "firefox";
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GTK_USE_PORTAL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
  };
}
