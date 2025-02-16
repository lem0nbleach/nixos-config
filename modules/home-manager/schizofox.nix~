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
      sanitizeOnShutdown.enable = true;
      sandbox.enable = true;
    };
    
    extensions = {
      simplefox.enable = true;
      darkreader.enable = true;

      extraExtensions = {
        "webextension@bitwarden.com".install_url = "https://addons.mozilla.org/firefox/downloads/file/4410896/bitwarden_password_manager-2024.12.4.xpi";
      };
    };
  };
}
