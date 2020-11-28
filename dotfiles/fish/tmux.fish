# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

if test -z "$TMUX" -a -n "$DISPLAY" -a -z "$GNOME_TERMINAL_SCREEN"
    and not string match -qr kitty "$TERM"
    and status is-interactive

    set attach_session (tmux 2> /dev/null ls -F \
        '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
        awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')
    if test -n "$attach_session"
        exec tmux attach -t "$attach_session"
    else
        exec tmux
    end
end

