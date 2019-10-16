#!/bin/bash
xfconf-query  --channel xfce4-desktop \
--property /backdrop/screen0/monitorHDMI-2/workspace0/last-image \
--set $1
echo $1
