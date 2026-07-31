{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  environment.systemPackages = [ pkgs.pwvucontrol ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
