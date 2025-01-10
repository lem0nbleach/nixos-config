{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };

    # Zen Kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Secure boot utility
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
}
