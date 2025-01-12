{ pkgs, ...}:

{
  programs.git.enable = true;

  programs.git = {
    userName = "Lem0nbleach";
    userEmail = "feiyang.wu@fishstall.net";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
