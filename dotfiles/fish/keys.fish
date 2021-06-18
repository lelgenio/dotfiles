# {{@@ header() @@}}
#   __ _     _
#  / _(_)___| |__
# | |_| / __| '_ \
# |  _| \__ \ | | |
# |_| |_|___/_| |_|

if test "$EDITOR" = vim
    fish_vi_key_bindings
else
    fish_default_key_bindings
end

if test $fish_key_bindings = fish_vi_key_bindings

    bind           {{@@ key.left  @@}} backward-char
    bind -M visual {{@@ key.left  @@}} backward-char
    bind           {{@@ key.down  @@}} down-or-search
    bind -M visual {{@@ key.down  @@}} down-line
    bind           {{@@ key.up    @@}} up-or-search
    bind -M visual {{@@ key.up    @@}} up-line
    bind           {{@@ key.right @@}} forward-char
    bind -M visual {{@@ key.right @@}} forward-char

    bind -m insert {{@@ key.insertMode         @@}} repaint-mode
    bind -m insert {{@@ key.insertMode.upper() @@}} beginning-of-line repaint-mode

    bind -M insert {{@@ key.insertQuit @@}} repaint-mode -m default

    bind yy fish_clipboard_copy

end

bind \cy 'commandline | wl-copy -n'

# Enable fzf key bindings
fzf_key_bindings

