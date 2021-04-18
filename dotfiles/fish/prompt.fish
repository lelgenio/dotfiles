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

############################################################
# Git
############################################################

function _fish_prompt_git_status -a git_status_s code symbol color
    echo $git_status_s | string match -qr "^$code"
    and _fish_prompt_color "$color" "$symbol"
end


function fish_git_prompt
    pushd (string replace -r '/\.git/.*' '' "$PWD")

    ############################################################
    # Check if in a git repo and save branch and status
    ############################################################
    set git_branches (git branch --all 2> /dev/null)
        or return

    string match -qr '\* (?<git_branch>.*)' $git_branches
    string match -qr 'detached at (?<git_detach_branch>.*)\)' $git_branch
    string match -qr 'remotes/(?<git_remote_branches>.*)' $git_branches
    string match -qr '(?<git_remotes>.*)/' $git_remote_branches

    set git_status_s (git status -s | string collect)

    _fish_prompt_normal " on "

    ############################################################
    # Left side represents Index/Filesystem
    ############################################################
    # Modified
    _fish_prompt_git_status "$git_status_s" '.M' '~' 'yellow'
    # Deleted
    _fish_prompt_git_status "$git_status_s" '.D' '-' 'red'
    # Untraked files exist
    _fish_prompt_git_status "$git_status_s" '\?\?' '?' 'normal'

    # Print name of branch or checkedout commit
    if test -n "$git_detach_branch"
       _fish_prompt_warn   "$git_detach_branch"
    else if  test -n "$git_branch"
       _fish_prompt_accent "$git_branch"
    else
       _fish_prompt_warn "init"
    end

    # print a "↑" if ahead of origin
    for git_remote in (echo $git_remotes | sort -u)
        # Remote has the current branch
        string match -qr "$git_remote"/"$git_branch" $git_remote_branches
        # Check if remote is different
        and not git diff --quiet HEAD "$git_remote"/"$git_branch"
        and _fish_prompt_normal '↑'
        and break
    end

    ############################################################
    # Right side represents WorkTree/Staged
    ############################################################
    # New file
    _fish_prompt_git_status "$git_status_s" 'A.' '+' 'green'
    # Modified
    _fish_prompt_git_status "$git_status_s" 'M.' '~' 'green'
    # Moved
    _fish_prompt_git_status "$git_status_s" 'R.' '→' 'yellow'
    # Deletion staged
    _fish_prompt_git_status "$git_status_s" 'D.' '-' 'red'

    popd
end


############################################################
# Vi mode indicator
############################################################

function fish_vimode_prompt # Not fish_mode_prompt!

    if not test $fish_key_bindings = fish_vi_key_bindings
        printf '\e[5 q' # Bar
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

    if test -n "$SSH_TTY"
        _fish_prompt_normal " at "
        _fish_prompt_accent "$hostname"
    end

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
