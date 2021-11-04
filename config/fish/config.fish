mcfly init fish | source
zoxide init fish | source
alias ls=exa
alias icat="kitty +kitten icat"
alias btm="btm --color gruvbox-light"
alias kakc="kak -c"
alias gst="git status"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gcc="git commit"
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gdc="git diff --cached"

function voiddb
    void $HOME/.config/void/db/$argv[1].db
end

function fish_prompt
    set -l username ""
    if test -n "$SSH_CLIENT" || test -n "$SSH_TTY" || test -n "$SSH_CONNECTION"
        set username (set_color brblack)(whoami)@(hostname)" "(set_color normal)
    end
    set -l path (set_color -ou green)(pwd | sed "s:^$HOME:~:")(set_color normal)
    set -l git_info ""
    if git status >/dev/null 2>/dev/null
        set -l branch_name (git rev-parse --abbrev-ref @)
        if test $branch_name = "HEAD"
            set branch_name (git describe --all --contains --always HEAD)
        end
        set git_info (set_color -i yellow)" $branch_name"(set_color normal)

        set -l git_mod ""

        set -l git_st_porcelain (git status --porcelain)
        if test -n "$git_st_porcelain"
            set git_mod "$git_mod~"
        end

		if git rev-parse @{u} >/dev/null 2>/dev/null
            if test (git rev-list @..@{u} --count) -ne 0 || test (git rev-list @{u}..@ --count) -ne 0
                set git_mod "$git_mod^"
            end

            if test -n "$git_mod"
                set git_mod " "(set_color -o brred)"$git_mod"(set_color normal)
            end
        else
            set git_mod " "(set_color -o brred)"?"(set_color normal)
        end

        set git_info $git_info$git_mod
    end
    set -l prompt_char ">"
    if test (id -u) -eq "0"
        set prompt_char "#"
    end

	echo -e ""
    echo -n "$username$path$git_info$prompt_char "
end

if test (ssh-add -L) = "The agent has no identities."
    echo "Input SSH key passphrase, or press <ret> to skip."
    ssh-add
end
