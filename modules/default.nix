{ lib, ... }:

{
  options.anchovy = lib.mkOption {
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
  ];
}
