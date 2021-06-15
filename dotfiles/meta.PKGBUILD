# Maintainer: Leonardo Eugênio <lelgenio@disroot.org>
pkgname=lelgenio-meta
pkgver=1
pkgrel=2
pkgdesc="Metapackage for swaywm related programs"
arch=('any')
url="http://git.disroot.org/lelgenio/dotfiles"
license=('GPL')

depends=(

    fish cronie git man-db

    # DE
        # Sway
        sway swayidle swaylock waybar
        # Menu
        bemenu-wlroots j4-dmenu-desktop
        # Utility
        ruby-fusuma light mako kanshi udiskie redshift-wayland-git
        wtype caffeinated xdg-desktop-portal-wlr pipewire-media-session
        # Greeter
        greetd greetd-gtkgreet
        # Configuration manager
        dotdrop

    # Packages
    pkgfile paru

    # passwords and auth
    pass gnupg pam-gnupg

    # Dav
    vdirsyncer khal khard

    # Audio
    pulseaudio  pulseaudio-alsa pulseaudio-bluetooth
    pamixer pulsemixer pavucontrol

    # Fonts
        inter-font ttf-ms-fonts
        otf-nerd-fonts-fira-code

        # Icons
        otf-font-awesome ttf-font-awesome

        # Emoji and stuff
        noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

    # Screenshot
    grim slurp swappy wl-clipboard imagemagick wf-recorder

    # Theme
    # {%@@ if 'papirus' in "{{@@ icon_theme @@}}".lower() @@%} #
        papirus-icon-theme papirus-folders papirus-libreoffice-theme
    # {%@@ elif 'mint' in "{{@@ icon_theme @@}}".lower() @@%} #
        mint-y-icons mint-x-icons
    # {%@@ endif @@%} #

    # {%@@ if 'mint' in "{{@@ gtk_theme @@}}".lower() @@%} #
        mint-themes
    # {%@@ elif 'materia' in "{{@@ gtk_theme @@}}".lower() @@%} #
        materia-custom-accent
        bc sassc inkscape  # Make dependencies
    # {%@@ endif @@%} #

        capitaine-cursors

    # Terminal
        # Emulators
        kitty alacritty
        #Tools
        tuxi  translate-shell
        ranger atool p7zip jq fzf
        neofetch htop bpytop
        # Replacements
        #ls cat rm -rf    grep    find sed diff  cd
        exa bat trash-cli ripgrep fd   sd  diffr zoxide

    # Network
        iwd dhcpcd
        # Transfer
        wget curl rsync rclone nmap
        # Testing
        gnu-netcat tor mtr speedtest-cli
        # ssh
        openssh sshfs fail2ban
        # Bluetooth
        bluez bluez-utils

    # Browser
    qutebrowser youtube-dl

    # Email
    neomutt urlview isync

    # Files
    thunar
    syncthing xdg-user-dirs
    transmission-cli deemix

    # Media
    pqiv mpv
    mpd mpc ncmpcpp mpdris2
    playerctl clyrics
    blender gimp kdenlive
    zathura zathura-pdf-mupdf

    # Office
    libreoffice-fresh libreoffice-fresh-pt-br hunspell-pt-br

    # Programing
        kakoune kak-lsp
        neovim python-pynvim neovim-symlinks

        bash-language-server

        # Python
        ipython bpython

        # Python lsp
        python-language-server
        python-pylint autopep8 pyls-mypy
        python-mccabe python-rope python-pyflakes
        python-pycodestyle python-pydocstyle

        # Compiled
        rust gcc gdb

        # work
        mariadb
        php7 php7-apache
        phpmyadmin
        lipsum emmet-cli
        blade-formatter prettier
        nodejs-less nodejs-less-plugin-clean-css

    # Virt
    qemu

    # Gtk
    gtk3-nocsd-legacy-git

    # Qt
    qt5-base qt5-wayland qt5ct kvantum-qt5

    # Chat
    discord telegram-desktop

    # Gaming
    steam lutris lutris-wine-meta wine wine-mono winetricks

    # File thumbnails
    tumbler  ffmpegthumbnailer poppler-glib
    libgsf libgepub libopenraw freetype2

)

# vim: ft=sh
