{ inputs, ... }:

{
  home-manager = {
    users."lem0nbleach" = ../../../modules/profiles/croaker/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
