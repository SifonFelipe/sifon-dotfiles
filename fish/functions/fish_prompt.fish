function fish_prompt
    set -l last_status $status

    echo

    # current directory
    set_color 39ff88 -o
    echo -n (basename (pwd))

    # git branch
    set git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if test -n "$git_branch"
        set_color 53605a
        echo -n "  "

        set_color d75fff
        echo -n " $git_branch"
    end

    echo

    # prompt symbol
    if test $last_status -eq 0
        set_color 39ff88 -o
    else
        set_color ff4d4d -o
    end

    echo -n "❯ "

    set_color normal
end
