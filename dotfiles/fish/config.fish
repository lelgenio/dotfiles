# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|


source {$__fish_config_dir}/env.fish
source {$__fish_config_dir}/alias.fish
source {$__fish_config_dir}/keys.fish
source {$__fish_config_dir}/wm.fish
source {$__fish_config_dir}/tmux.fish
source {$__fish_config_dir}/colors.fish
source {$__fish_config_dir}/prompt.fish


function _fish_autoreload --on-signal SIGHUP
    source {$__fish_config_dir}/config.fish
    kitty @ set-colors -a ~/.config/kitty/kitty.conf
    kitty @ set-background-opacity "{{@@ opacity @@}}"
end