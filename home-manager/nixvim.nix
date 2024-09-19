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
      lsp = {
        enable = true;
	servers = {
	  rust-analyzer = {
	    enable = true;
	    installCargo = false;
	    installRustc = false;
	  };
	};
      };
      cmp = {
        autoEnableSources = true;
	settings.sources = [
	  { name = "nvim_lsp"; }
	];
      };
      nvim-colorizer.enable = true;
    };
  };
}
