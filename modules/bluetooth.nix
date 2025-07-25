{ lib, config, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
