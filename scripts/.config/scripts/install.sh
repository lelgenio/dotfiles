pacman -S git pacman-contrib base base-devel --needed

# getting yay
git clone http://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Install a lot of things
yay -Syu --noconfirm --needed \
    # DE
    sway light mako pulseaudio udiskie\
    httpie jq keepmenu\
    # Theming
    materia-custom-accent papirus-icon-theme-git papirus-folders-git capitaine-cursors \
    # Terminal stuff
    termite neovim ranger zsh mimeo atool\
    # Shell
    zsh zsh-completions zsh-syntax-highlighting antigen-git powerline-fonts\
    # Web
    qutebrowser \
    # Gaming
    steam lutris \
    # Media
    gimp kdenlive mpv mpd mpc ncmpcpp 


#useradd -mG wheel lelgenio
su -u lelgenio -c 'cd ~;git clone http://github.com/lelgenio/dotfiles.git .config;.config;scripts/install-user'
if [ ! -f /etc/zsh/zshenv ] 
then
    mkdir -p /etc/zsh
    .dots/myetc/etc/zsh/zshenv /etc/zsh/zshenv
fi
