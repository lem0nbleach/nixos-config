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
    ./common
    ./desktop
    ./server
    ./hardware
  ];
}
