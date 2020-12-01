#{{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|


# Fine, I'll do it myself
function fish_vi_cursor;end
function fish_mode_prompt;end


############################################################
# Color helpers
############################################################

function _fish_prompt_color -a color
    # separate line needed for bold normal
    set_color $color
    set_color --bold
    set -e argv[1]
    echo -en $argv
end

alias _fish_prompt_accent "_fish_prompt_color '{{@@ accent_color @@}}'"
alias _fish_prompt_warn   "_fish_prompt_color 'yellow'"

alias _fish_prompt_normal "_fish_prompt_color 'normal'"

function _fish_prompt_git_status
    git status -s | grep "^$argv[1]" &> /dev/null &&
    _fish_prompt_color $argv[3] $argv[2]
end


############################################################
# Git
############################################################

function fish_git_prompt

    set _git_branch (git branch --show-current 2> /dev/null)
    if not test -n "$_git_branch"
        return
    end

    _fish_prompt_normal " on "

    ############################################################
    # Left side represents Index/Filesystem
    ############################################################
    # Modified
    _fish_prompt_git_status '.M' '~' '{{@@ color.normal.yellow   @@}}'
    # Deleted
    _fish_prompt_git_status '.D' '-' '{{@@ color.normal.red      @@}}'

    # Untraked files exist
    _fish_prompt_git_status '??' '?' '{{@@ color.txt             @@}}'

    # Print name of branch and a "↑" if ahead of origin
    _fish_prompt_accent "$_git_branch"
    for remote in (git remote)
        if not git branch --remotes |
                grep "$remote"/"$_git_branch" &> /dev/null
            continue
        end
        if not git diff --quiet -- HEAD "$remote"/"$_git_branch"
            _fish_prompt_color '{{@@ color.txt @@}}' '↑'
        end
    end

    ############################################################
    # Right side represents WorkTree/Staged
    ############################################################
    # New file
    _fish_prompt_git_status 'A.' '+' '{{@@ color.normal.green    @@}}'
    # Modified
    _fish_prompt_git_status 'M.' '~' '{{@@ color.normal.green    @@}}'
    # Deletion staged
    _fish_prompt_git_status 'D.' '-' '{{@@ color.normal.red      @@}}'
end


############################################################
# Vi mode indicator
############################################################

function fish_vimode_prompt # Not fish_mode_prompt!

    if not test $fish_key_bindings = fish_vi_key_bindings
        return
    end

    # Set cursor shape
    if test $fish_bind_mode = insert
        printf '\e[5 q' # Bar
    else
        printf '\e[1 q' # Block
    end

    # Print mode symbol, N for normal, I for insert, etc...
    # on most cases first letter of mode name
    _fish_prompt_accent (
    switch $fish_bind_mode
        case replace_one
            printf 'o'
        case default
            printf 'n'
        case '*'
            printf (string match -r '^.' $fish_bind_mode )
    end | string upper
    )' '
end


############################################################
# Main prompt
############################################################

function fish_prompt
    # Save current status as it may be overwritten before usage
    set _status $status

    _fish_prompt_accent $USER
    _fish_prompt_normal " in "
    _fish_prompt_accent (prompt_pwd)

    fish_git_prompt

    # Line break
    echo

    fish_vimode_prompt

    if test $_status -ne 0
        _fish_prompt_warn "$_status "
    end

    if test $USER = root
        _fish_prompt_normal '# '
    else
        _fish_prompt_normal '$ '
    end

    # Reset colors
    set_color normal
end


# These don't seem to work
# set fish_cursor_default     block      blink
# set fish_cursor_insert      line       blink
# set fish_cursor_replace_one underscore blink
# set fish_cursor_visual      block