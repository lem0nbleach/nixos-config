{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.helix
    pkgs.nixd
    pkgs.nil
  ];
}
