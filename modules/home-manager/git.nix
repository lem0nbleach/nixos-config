{ pkgs, ...}:

{
  programs.git.enable = true;

  programs.git = {
    userName = "Feiyang Wu";
    userEmail = "feiyang.wu@fishstall.net";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
