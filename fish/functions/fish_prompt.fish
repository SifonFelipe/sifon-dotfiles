function fish_prompt
    set -l last_status $status

    # blank line
    echo

    # path + git branch
    set_color 50fa7b -o  # for synthwave -> #bd93f9
    echo -n (basename (pwd))

    set git_branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -n "$git_branch"
        set_color normal
        echo -n " on "
        set_color f25aab -o
        echo -n " $git_branch"
    end

    echo

    # ❯ normal or red, according to status
    if test $last_status -eq 0
        set_color 50fa7b -o
        echo -n "❯ "
    else
        set_color ff5555 -o
        echo -n "❯ "
    end

    set_color normal
end
