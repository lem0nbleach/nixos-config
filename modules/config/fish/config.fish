if status is-interactive
    # Commands to run in interactive sessions can go here
end

if uwsm check may-start
    exec uwsm start default
end

zoxide init fish | source
