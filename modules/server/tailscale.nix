{
  lib,
  config,
  pkgs,
  ...
}:

let
  tailscaleInterface =
    if config.marlin then
      "ens18"
    else if config.anchovy then
      "wlp192s0"
    else
      "enp8s0";
in
{
  services.tailscale.enable = true;
  # needed in order to use an exit node
  networking.firewall.checkReversePath = "loose";

  # Native nftables support
  # 1. Enable the service and the firewall
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # 3. Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # Enabling exitnode and subnet router
  services.tailscale.useRoutingFeatures = "both";

  # UDP optimization
  environment.systemPackages = [
    pkgs.ethtool
  ];
  services.networkd-dispatcher = {
    enable = true;
    rules."50-tailscale-optimizations" = {
      onState = [ "routable" ];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -K ${tailscaleInterface} rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
}
