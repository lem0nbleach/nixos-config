{ lib, config, pkgs, ... }:

lib.mkIf (config.anchovy || config.croaker) {
  # environment.systemPackages = [ pkgs.pwvucontrol ];
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # No X11 support: mod.x11-bell segfaults PipeWire whenever Xwayland exits
    # (it runs with -terminate 10), which drops every audio client with it.
    package = pkgs.pipewire.override { x11Support = false; };
  };
}
