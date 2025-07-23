{ lib, ... }:

{
  options.anchovy = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  options.croaker = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  options.marlin = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };

  imports = [
    ./fish.nix
    ./steam.nix
    ./hyprland.nix
    ./nh.nix
    ./watt.nix
    ./tailscale.nix
    ./sound.nix
    ./ssh.nix
    ./network-tools.nix
    ./mozilla.nix
    ./input.nix
    ./docker.nix
    ./battery-notification.nix
    ./helix.nix
  ];
}
