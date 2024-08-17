{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "hyprland";
        user = "lem0nbleach";
      };
      default_session = initial_session;
    };
  };
}
