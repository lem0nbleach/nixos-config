{ ... }:

{
  imports = [
    ../../nixos/core/zsh.nix
    ../../nixos/core/auto-login.nix
    ../../nixos/core/stylix.nix
    ../../nixos/extra/obs.nix
    ../../nixos/extra/flatpak.nix
    ../../nixos/extra/docker.nix
  ];
}
