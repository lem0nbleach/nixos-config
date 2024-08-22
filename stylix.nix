{ pkgs, ... }:

{
  stylix.enable = true;

  stylix.base16Scheme = {
    base00 = "000000"; #000000
    base01 = "37353b"; #37353b
    base02 = "45424a"; #45424a
    base03 = "5e5966"; #5e5966
    base04 = "9598b8"; #9598b8
    base05 = "a3a7d4"; #a3a7d4
    base06 = "b2b7eb"; #b2b7eb
    base07 = "c7cdff"; #c7cdff
    base08 = "ff5757"; #ff5757
    base09 = "B4EF68"; #B4EF68
    base0A = "39A8ED"; #A6F0E2
    base0B = "A6F0E2"; #39A8ED 
    base0C = "D1F1B9"; #D1F1B9
    base0D = "F6FF69"; #F6FF69
    base0E = "E284F5"; #E284F5
    base0F = "FF61AF"; #FF61AF
  };
  stylix.polarity = "dark";
  stylix.image = ./home-manager/window-manager/wallpaper/EYE.jpg;
  stylix.cursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
