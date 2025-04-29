{ inputs, ... }:

{
  home-manager = {
    users."lem0nbleach" = ../../../modules/profiles/desktop/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
