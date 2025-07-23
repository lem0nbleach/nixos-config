{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ../../config/marlin.nix
      ../../modules
    ];

  config = {
    marlin = true;

    nix.settings.experimental-features = ["nix-command" "flakes"];

    boot.loader = {
      grub.device = "/dev/sda";
      grub.useOSProber = true;
      timeout = 1;
    };

    networking.hostName = "marlin"; # Define your hostname.

    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [ 2049 9002 3080 81 444];

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
      EDITOR = "hx";
    };

    users.users.lem0nbleach = {
      isNormalUser = true;
      description = "Feiyang Wu";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.bash;
    };

    nixpkgs.config.allowUnfree = true;

    services.tailscale.useRoutingFeatures = "both";

    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
