{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim
    git
    dig
    gcc
    ripgrep
    gnumake
    unzip
    gzip
    fd
    lua
    brightnessctl
    zoxide
    zsh
    thefuck
  ];
}
