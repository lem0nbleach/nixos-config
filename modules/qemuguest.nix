{ lib, config ... }:

lib.mkIf config.marlin {
  services.qemuGuest.enable = true;
}
