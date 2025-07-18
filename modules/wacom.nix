{ lib, config, ... }:

lib.mkIf config.croaker {
  services.xserver.wacom.enable = true;
}
