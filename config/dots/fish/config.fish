function fish_greeting
    random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!"
end

if set -q ZELLIJ
else
    zellij
end

set -U hydro_color_prompt blue

zoxide init fish | source
