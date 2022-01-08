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

    # You get a wayland, and you get a wayland. Everybody get's a wayland!
    # set -x MOZ_ENABLE_WAYLAND 1
    # set -x CLUTTER_BACKEND wayland
    # set -x QT_QPA_PLATFORM wayland-egl
    # set -x ECORE_EVAS_ENGINE wayland-egl
    # set -x ELM_ENGINE wayland_egl
    # set -x SDL_VIDEODRIVER wayland
    # set -x _JAVA_AWT_WM_NONREPARENTING 1
    # set -x NO_AT_BRIDGE 1

    # Hardware acceleration
    set -x MOZ_DISABLE_RDD_SANDBOX 1

    # Allow sway decoration on gtk3 apps
    set -x GTK_CSD 0
    test -f '/usr/lib/libgtk3-nocsd.so.0' &&
        set -x LD_PRELOAD '/usr/lib/libgtk3-nocsd.so.0'

    # set -x QT_SCALE_FACTOR 1.0001
    # set -x QPA_PLATFORM wayland
    # set -x QT_QPA_PLATFORM wayland

    # Needed for xdg-dektop-portal
    set -x XDG_SESSION_TYPE     wayland
    set -x XDG_SESSION_DESKTOP  sway
    set -x XDG_CURRENT_DESKTOP  sway

    # this should not be necessary, but whatever
    if not pidof sway &> /dev/null
        pkill -HUP -u "$USER" runsvdir
        exec dbus-launch --exit-with-session sway
    end
end

if test "$XDG_VTNR" = 1
    and test -z "$DISPLAY$WAYLAND_DISPLAY"

    esway &> .swaylog
    # ei3 &> .i3log
    # ebsp &> .bsplog

end

