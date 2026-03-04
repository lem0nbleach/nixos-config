{ lib, ... }:

{
  hjem.users.lem0nbleach = {
    clobberFiles = lib.mkForce true;
    files = {
      ".config/git/config".source = ./dots/git/config;
    };
  };
}
