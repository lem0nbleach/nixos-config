{ lib, ... }:

{
  hjem = {
    clobberByDefault = true;
    users.lem0nbleach.files = {
      ".config/git/config".source = ./dots/git/config;
    };
  };
}
