{ config, pkgs, pkgsStable, inputs, lib, ... }:

{
  imports =
    [
      ../../hjem/croaker.nix
      ../../modules
      ./packages.nix
      ./hardware-configuration.nix
    ];

  config = {
    croaker = true;

    boot = {
      loader.efi.canTouchEfiVariables = true;

      kernel.sysctl = { "kernel.split_lock_mitigate" = 0; };
      kernelParams = [
        "video=DP-1:2560x1440@60"
        "video=HDMI-A-1:2560x1440@60"
      ];

      loader.systemd-boot.enable = true;
    };
    
    networking.hostName = "croaker";

    networking.networkmanager.enable = true;

    networking.interfaces.enp8s0.wakeOnLan.enable = true;

    time.timeZone = "America/New_York";

    users.users.lem0nbleach = {
      isNormalUser = true;
      description = "It's me aye";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      shell = pkgs.fish;
    };

    system.stateVersion = "24.05";

    environment.sessionVariables = {
      BROWSER = "firefox";
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings.max-jobs = 4;
    nix.settings.cores = 4;
  };
}
