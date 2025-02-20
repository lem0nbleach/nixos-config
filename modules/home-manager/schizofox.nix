{
  programs.schizofox.enable = true;

  programs.schizofox = {
    search = {
      defaultSearchEngine = "Brave";
      removeEngines = ["Google" "Bing"];
      searxUrl = "https://searx.be";
      searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
    };

    security = {
      sanitizeOnShutdown.enable = false;
      sandbox.enable = true;
    };
    
    extensions = {
      darkreader.enable = true;

      enableExtraExtensions = true;
      extraExtensions = {
        "biwarden@bitwarden.com".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
      };
    };
    
    misc = {
      drm.enable = true;
      drmFix = true;
    };
  };
}
