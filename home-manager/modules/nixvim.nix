{ pkgs, ... }:

{
  programs.nixvim.enable = true;

  programs.nixvim = {

    defaultEditor = true;

    plugins = {
      lualine.enable = true;
      neo-tree = {
        enable = true;
	filesystem = {
	  filteredItems ={
	    visible = true;
	    hideDotfiles = false;
            hideGitignored = false;
	    showHiddenCount = false;
          };
        };
      };
    };
  };
}
