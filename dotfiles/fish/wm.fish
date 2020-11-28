# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

########################################################
# start window manager if using tty1
########################################################
function esway

    # fix buggy java apps
    set -x _JAVA_AWT_WM_NONREPARENTING 1

    # Allow sway decoration on gtk3 apps
    set -x GTK_CSD 0
    test -f '/usr/lib/libgtk3-nocsd.so.0' &&
        set -x LD_PRELOAD '/usr/lib/libgtk3-nocsd.so.0'

    # set -x QT_SCALE_FACTOR 1.0001
    # set -x QPA_PLATFORM wayland
    # set -x QT_QPA_PLATFORM wayland

    # Neede for xdg-dektop-portal
    set -x XDG_CURRENT_DESKTOP  sway
    set -x XDG_SESSION_TYPE     wayland

    # this should not be necessary, but whatever
    pidof sway || exec sway

end

if test "$XDG_VTNR" = 1
    and test -z "$DISPLAY"

    esway &| tee .swaylog
    # ei3 &> .i3log
    # ebsp &> .bsplog

end

