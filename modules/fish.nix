{ lib, config, pkgs, ... }:

lib.mkMerge [
  {
    documentation.man.generateCaches = false;

    programs = {
      fish = {
        enable = true;
        shellAbbrs = {
          ns = "nix-shell --run fish -p";
        };
      };
      zoxide.enable = true;
      direnv = {
        enable = true;
        enableFishIntegration = true;
      };
      command-not-found.enable = false;
      nix-index = {
        enable = true;
        enableFishIntegration = true;
      };
    };

    environment.systemPackages = [
      pkgs.fishPlugins.hydro
    ];
  }

  (lib.mkIf (config.anchovy || config.croaker){
    programs.fish.interactiveShellInit = ''
      # Greetings with lovely Aussie accent
      function fish_greeting
        random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!" "How ja doing?" "How is it going?" "Good work mate" "Good on ya mate"
      end

      # Since this declared by `programs.fish.interactiveShellInit`,
      # there is no need to check if this is interactive like the doc.

      # Configure auto-attach/exit to your likings (default is off).
      set ZELLIJ_AUTO_EXIT true
      set ZELLIJ_AUTO_ATTACH true
      # For some reason I have to use this script instead of the if condition one from fish's doc
      eval (zellij setup --generate-auto-start fish | string collect)

      set -U hydro_color_prompt blue
      function fish_mode_prompt; end;
      function update_nshell_indicator --on-variable IN_NIX_SHELL
        if test -n "$IN_NIX_SHELL";
          set -g hydro_symbol_start "impure "
        else
          set -g hydro_symbol_start
        end
      end
      update_nshell_indicator
    '';
    environment.systemPackages = with pkgs; [
      zellij
    ];
  })

  (lib.mkIf config.marlin {
    programs.fish.interactiveShellInit = ''
      function fish_greeting
        random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!" "How ja doing matey?" "How is it going my dude?" "Good work mate" "Good on ya mate"
      end

      set -U hydro_color_prompt blue
      function fish_mode_prompt; end;
      function update_nshell_indicator --on-variable IN_NIX_SHELL
        if test -n "$IN_NIX_SHELL";
          set -g hydro_symbol_start "impure "
        else
          set -g hydro_symbol_start
        end
      end
      update_nshell_indicator
    '';
  })
]
