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
        ydotool wtype caffeinated
        # Configuration manager
        dotdrop

    # Packages
    pkgfile paru

    # passwords and auth
    pass gnupg pam-gnupg

    # Dav
    vdirsyncer khal khard

    # Audio
    pulseaudio pamixer

    # Fonts
    inter-font ttf-material-wifi-icons-git
    otf-nerd-fonts-fira-code

    # Screenshot
    grim slurp swappy wl-clipboard imagemagick wf-recorder wshowkeys

    # Theme
    materia-custom-accent papirus-icon-theme
    papirus-folders capitaine-cursors

    # Terminal
        # Emulators
        kitty alacritty
        #Tools
        ranger atool p7zip tree jq fzf
        neofetch htop
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
    nautilus
    syncthing xdg-user-dirs
    transmission-cli deemix

    # Media
    pqiv mpv
    mpd mpc ncmpcpp
    blender gimp kdenlive

    # Office
    libreoffice-fresh libreoffice-fresh-pt-br hunspell-pt-br papirus-libreoffice-theme

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

    rust gcc gdb

    # Virt
    qemu

    # Gtk
    gtk3-nocsd-git

    # Qt
    qt5-base qt5-wayland qt5ct kvantum-qt5

    # Chat
    discord telegram-desktop

    # Gaming
    steam lutris lutris-wine-meta wine wine-mono winetricks

)

# vim: ft=sh