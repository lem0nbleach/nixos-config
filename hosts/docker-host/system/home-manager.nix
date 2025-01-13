{ inputs, ... }:

{
  home-manager = {
    users."lem0nbleach" = ../../../modules/profiles/docker-host/home.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
