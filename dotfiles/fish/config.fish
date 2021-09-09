# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

set -U fish_features stderr-nocaret qmark-noglob regex-easyesc

source {$__fish_config_dir}/env.fish
source {$__fish_config_dir}/wm.fish
source {$__fish_config_dir}/alias.fish
source {$__fish_config_dir}/keys.fish
source {$__fish_config_dir}/tmux.fish
source {$__fish_config_dir}/colors.fish

{%@@ if starship @@%}
    starship init fish | source
    # Set cursor shape
    printf '\e[5 q' # Bar
{%@@ else @@%}
    source {$__fish_config_dir}/prompt.fish
{%@@ endif @@%}


function _fish_autoreload --on-signal SIGHUP
    source {$__fish_config_dir}/config.fish

    if test "$TERM" = "xterm-kitty"
        kitty @ set-colors -a ~/.config/kitty/kitty.conf
        kitty @ set-background-opacity "{{@@ opacity @@}}"
    end
end
