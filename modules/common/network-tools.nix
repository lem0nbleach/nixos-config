{ pkgs, ... }:

{
  programs.mtr.enable = true;

  environment.systemPackages = [
    pkgs.dig
  ];
}
