function fish_greeting
    random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!"
end

if status is-interactive
    # Configure auto-attach/exit to your likings (default is off).
    # set ZELLIJ_AUTO_ATTACH true
    set ZELLIJ_AUTO_EXIT true
    eval (zellij setup --generate-auto-start fish | string collect)
end

set -U hydro_color_prompt blue

zoxide init fish | source
