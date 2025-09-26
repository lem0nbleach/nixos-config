{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy)
{
  services.udev.packages = [
    pkgs.qmk-udev-rules
  ];
}
