#!/bin/sh
# {{@@ header() @@}}

export XKB_DEFAULT_LAYOUT=us
export XKB_DEFAULT_VARIANT=colemak
export XKB_DEFAULT_OPTIONS=lv3:lsgt_switch,grp:shifts_toggle

schema=org.gnome.desktop.interface

# In case of errors, kvantummanager opens a window
# this is retarded
gsettings set $schema gtk-theme    '{{@@ gtk_theme     @@}}'
gsettings set $schema icon-theme   '{{@@ icon_theme    @@}}'
gsettings set $schema cursor-theme '{{@@ cursor_theme  @@}}'

exec cage -d -s -m last -- gtkgreet -c fish
