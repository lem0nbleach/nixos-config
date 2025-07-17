{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7 d --keep 7";
    flake = "/home/lem0nbleach/nixos";
  };
}
