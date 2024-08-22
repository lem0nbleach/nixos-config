{ pkgs, ... }:

{
  stylix.enable = true;

  /*
    base00 - Default Background
    base01 - Lighter Background (Used for status bars, line number and folding marks)
    base02 - Selection Background
    base03 - Comments, Invisibles, Line Highlighting
    base04 - Dark Foreground (Used for status bars)
    base05 - Default Foreground, Caret, Delimiters, Operators
    base06 - Light Foreground (Not often used)
    base07 - Brightest Foreground (Not often used)
    base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A - Classes, Markup Bold, Search Text Background
    base0B - Strings, Inherited Class, Markup Code, Diff Inserted
    base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D - Functions, Methods, Attribute IDs, Headings
    base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  base00: "#1d2021" # ----
  base01: "#3c3836" # ---
  base02: "#504945" # --
  base03: "#665c54" # -
  base04: "#bdae93" # +
  base05: "#d5c4a1" # ++
  base06: "#ebdbb2" # +++
  base07: "#fbf1c7" # ++++
  base08: "#fb4934" # red
  base09: "#fe8019" # orange
  base0A: "#fabd2f" # yellow
  base0B: "#b8bb26" # green
  base0C: "#8ec07c" # aqua/cyan
  base0D: "#83a598" # blue
  base0E: "#d3869b" # purple
  base0F: "#d65d0e" # brown
  */
  /*
  stylix.base16Scheme = {
    base00 = "000000"; #000000
    base01 = "41434a"; #38393d
    base02 = "4f5363"; #414561
    base03 = "565f7d"; #41377a
    base04 = ""; #7F83B2
  };
  */
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
