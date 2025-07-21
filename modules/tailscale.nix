{ lib, config, ... }:

lib.mkIf (config.anchovy || config.marlin) {
  services.tailscale.enable = true;
  # needed in order to use an exit node
  networking.firewall.checkReversePath = "loose";
}
