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
        fuzzel bemenu-wlroots j4-dmenu-desktop
        # Utility
        ruby-fusuma light mako kanshi udiskie
        gammastep
        wtype caffeinated
        # Screensharing
        xdg-desktop-portal-wlr pipewire pipewire-media-session libpipewire02
        # Greeter
        greetd greetd-gtkgreet
        # Configuration manager
        dotdrop xsettingsd

        # Boot logo
        plymouth plymouth-theme-red-loader-git

    # Packages
    pkgfile paru

    # passwords and auth
    pass gnupg

    # Dav
    vdirsyncer khal khard

    # Audio
    pulseaudio pulseaudio-rtp pulseaudio-alsa pulseaudio-bluetooth
    pamixer pulsemixer pavucontrol

    # Fonts
        inter-font ttf-ms-fonts ttf-dejavu
        nerd-fonts-hack nerd-fonts-fira-code

        # Icons
        otf-font-awesome ttf-font-awesome

        # Emoji and stuff
        noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

    # Screenshot
    grim slurp swappy wl-clipboard imagemagick wf-recorder

    # Theme
    # {%@@ if 'papirus' in icon_theme.lower() @@%} #
        papirus-icon-theme papirus-folders papirus-libreoffice-theme
    # {%@@ elif 'mint' in icon_theme.lower() @@%} #
        mint-y-icons mint-x-icons
    # {%@@ endif @@%} #

    # {%@@ if 'mint' in gtk_theme.lower().lower() @@%} #
        mint-themes
    # {%@@ elif 'orchis' in gtk_theme.lower().lower() @@%} #
        orchis-kde-theme-git
        orchis-theme-git
    # {%@@ elif 'materia' in gtk_theme.lower().lower() @@%} #
        materia-custom-accent
        bc sassc inkscape  # Make dependencies
    # {%@@ endif @@%} #

        capitaine-cursors

    # Terminal
        # Emulators
        kitty alacritty
        #Tools
        tuxi-git translate-shell tealdeer so
        ranger atool p7zip jq fzf
        neofetch htop bpytop
        inxi entr
        #Prompt
        starship
        # Replacements
        #ls cat rm -rf    grep    find sed diff  cd     fmt
        exa bat trash-cli ripgrep fd   sd  diffr zoxide par

    # Network
        iwd dhcpcd
        # Transfer
        wget curl rsync rclone nmap
        # Testing
        gnu-netcat tor mtr speedtest-cli
        inetutils net-tools
        # ssh
        openssh sshfs fail2ban
        # Bluetooth
        bluez bluez-utils bluez-plugins

    # Browser
    qutebrowser youtube-dl

    # Email
    neomutt urlview isync

    # Files
    thunar thunar-vcs-plugin thunar-volman
    thunar-archive-plugin engrampa
    syncthing xdg-user-dirs
    transmission-cli deemix

    # Media
    pqiv mpv
    mpd mpc ncmpcpp mpdris2
    playerctl clyrics
    kdeconnect
    blender gimp
    zathura zathura-pdf-mupdf

    # Office
    libreoffice-fresh libreoffice-fresh-pt-br hunspell-pt-br

    # Programing
        kakoune
        neovim python-pynvim neovim-symlinks

        shfmt bash-language-server

        # web lsp
        vscode-html-languageserver
        vscode-css-languageserver
        vscode-json-languageserver

        # php lsp
        nodejs-intelephense

        # Python
        ipython bpython

        # Python lsp
        python-language-server
        python-pylint autopep8 pyls-mypy
        python-mccabe python-rope python-pyflakes
        python-pycodestyle python-pydocstyle

        # rust lsp
        rust-analyzer

        # Compiled
        rust gcc gdb meson

        # work
        mariadb
        php7 php7-apache
        phpmyadmin
        lipsum-git emmet-cli
        blade-formatter prettier
        nodejs-less nodejs-less-plugin-clean-css
        uglify-js

    # Virt
    qemu

    # Power manager
    tlp

    # Gtk
    gtk3-nocsd-legacy-git

    # Qt
    qt5-base qt5-wayland qt5ct kvantum-qt5 qt5-styleplugins

    # X11
    xorg-xwayland

    # Tray
    libappindicator-gtk2 libappindicator-gtk3
    lib32-libappindicator-gtk2 lib32-libappindicator-gtk3

    # Chat
    discord telegram-desktop
    jitsi-meet-desktop-bin

    # Gaming
    steam lutris lutris-wine-meta wine wine-mono winetricks

    # File thumbnails
    tumbler  ffmpegthumbnailer poppler-glib
    libgsf libgepub libopenraw freetype2

)
pkgver() {
    date "+%Y%m%d.%H%M"
}

# vim: ft=sh
