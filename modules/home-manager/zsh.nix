{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
      ];
    };

    initExtra = ''eval "$(zoxide init zsh)"'';

    shellAliases = {
      nrbd = "sudo nixos-rebuild switch --flake ./hosts/#desktop";
      nrbs = "sudo nixos-rebuild switch --flake ./hosts/#server";
    };
  };

}

