{ lib, config, pkgs, ... }:

lib.mkMerge [
  (lib.mkIf (config.anchovy || config.marlin) {
    services.tailscale.enable = true;
    # needed in order to use an exit node
    networking.firewall.checkReversePath = "loose";
  })

  (lib.mkIf config.marlin {
    services.tailscale.useRoutingFeatures = "both";
    environment.systemPackages = [
      pkgs.ethtool
      pkgs.networkd-dispatcher
    ];
    services = {
      networkd-dispatcher = {
        enable = true;
        rules."50-tailscale" = {
          onState = ["routable"];
          script = ''
            "${pkgs.ethtool}/sbin/ethtool" -K ens18 rx-udp-gro-forwarding on rx-gro-list off
          '';
        };
      };
    };
  })
]
