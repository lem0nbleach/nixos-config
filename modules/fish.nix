{
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Greetings with lovely Aussie accent
      function fish_greeting
        random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!"
      end

      # Since this declared by `programs.fish.interactiveShellInit`,
      # there is no need to check if this is interactive like the doc.

      # Configure auto-attach/exit to your likings (default is off).
      set ZELLIJ_AUTO_ATTACH true
      set ZELLIJ_AUTO_EXIT true
      eval (zellij setup --generate-auto-start fish | string collect)

      set -U hydro_color_prompt blue
    '';
  };

  # Dependancies
  programs.zoxide.enable = true;

  environment.systemPackages = with pkgs; [
    fishPlugins.hydro
    zellij
  ];

    # Bash profile to start UWSM(Hyprland) at login and auto launch fish for all other interactive shell sessions.
  programs.bash.interactiveShellInit = ''
  	if shopt -q login_shell; then
  		if uwsm check may-start; then
      	exec uwsm start hyprland-uwsm.desktop
  	  fi
  	else
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]; then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
  	fi
  '';
}
