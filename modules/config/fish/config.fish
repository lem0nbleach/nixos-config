if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    random choice "Hello mate!" "Hi there!" "G'day!" "Howdy!"
end

zoxide init fish | source
thefuck --alias | source
