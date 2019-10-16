#!/bin/sh

scrot "Imagens/Screenshots/%Y-%m-%d_%H-%M-%S.$t" -e \ 
    "xclip -selection clipboard -target image/png -i $f" \
    -e "twmnc 'Captura de tela copiada e sava em $f' --ac 'feh $f'"
