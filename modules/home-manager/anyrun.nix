{ pkgs, inputs, ... }:

{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
         inputs.anyrun.packages.${pkgs.system}.applications
	 inputs.anyrun.packages.${pkgs.system}.shell
	 inputs.anyrun.packages.${pkgs.system}.websearch
      ];
      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      hideIcons = false;
      layer = "overlay";
      ignoreExclusiveZones = false;
    };
    extraCss = ''
      window {
        background-color: transparent;
      }
    '';
  };
}
