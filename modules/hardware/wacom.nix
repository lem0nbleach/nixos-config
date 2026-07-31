{ lib, config, ... }:

lib.mkIf config.croaker {
  # services.xserver.wacom.enable = true;

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];
}
