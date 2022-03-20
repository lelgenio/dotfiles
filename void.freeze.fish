#!/bin/env fish

xbps-query -m |
cut -d\  -f 2 |
string replace -ar -- '-[^-]*$' '' > void.freeze
