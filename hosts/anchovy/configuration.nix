{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./packages.nix
      ./hardware-configuration.nix
      ../../config/anchovy.nix
      ../../modules
    ];

  config = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [
      "amdgpu.sg_display=0"
    ];

    anchovy = true;
    networking.hostName = "anchovy";
    networking.networkmanager.enable = true;
    networking.nameservers = [ "192.168.88.50" ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.cores = 4;
    nix.settings.max-jobs = 3;

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

    environment.sessionVariables = {
      BROWSER = "firefox";
      NIXOS_OZONE_WL = "1";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GTK_USE_PORTAL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      MOZ_ENABLE_WAYLAND=1;
      XCURSOR_THEME="Bibata-Modern-Ice";
      SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock";
    };

    users.users.lem0nbleach = {
      isNormalUser = true;
      description = "Feiyang Wu";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      packages = [];
      shell = pkgs.fish;
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.11";
  };
}
