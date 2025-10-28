{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.helix
    pkgs.nixd
    pkgs.nil
    pkgs.kdePackages.qtdeclarative
  ];

  environment.sessionVariables = {
    EDITOR = "hx";
  };
}
