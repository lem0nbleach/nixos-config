{ ... }:

{
  imports = [
    ../../nixos/core/ssh.nix
    ../../nixos/extra/docker.nix
    ../../nixos/core/qemu-geust-agent.nix
  ];
}
