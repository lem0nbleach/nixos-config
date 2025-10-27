{ lib, config, ... }:

lib.mkIf config.anchovy {
  services.fwupd.enable = true;
}
