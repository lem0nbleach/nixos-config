{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    zsh
    neovim
    git
    kitty
    lsof
    dig
    iftop
    gcc
    foot
  ];
}
