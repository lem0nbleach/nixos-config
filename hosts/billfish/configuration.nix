{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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

    networking.networkmanager.enable = true;

    networking.firewall.allowedTCPPorts = [ 2049 9002 3080 81 444];

    networking.hosts = {
      "192.168.88.10" = [
        "actual.fishstall.net"
        "authentik.fishstall.net"
        "bazarr.fishstall.net"
        "forgejo.fishstall.net"
        "jellyfin.fishstall.net"
        "kavita.fishstall.net"
        "lidarr.fishstall.net"
        "matrix.fishstall.net"
        "netbox.fishstall.net"
        "pbs.fishstall.net"
        "pihole.fishstall.net"
        "prowlarr.fishstall.net"
        "pve.fishstall.net"
        "qbittorrent.fishstall.net"
        "radarr.fishstall.net"
        "sabnzbd.fishstall.net"
        "searxng.fishstall.net"
        "sonarr.fishstall.net"
        "speedtest.fishstall.net"
        "start.fishstall.net"
        "sv07.fishstall.net"
        "uptime-kuma.fishstall.net"
        "vaultwarden.fishstall.net"
      ];
    };
    
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
      description = "Feiyang Wu";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.bash;
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
