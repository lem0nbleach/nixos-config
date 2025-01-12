{ inputs, ... }:

{
  home-manager = {
    users."lem0nbleach" = ./../home.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}
