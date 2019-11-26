#!/bin/bash
#
#LICENSE#{{{
# Copyright (c) 2012 Tom Wambold
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#}}}
#ABOUT#{{{
# This script will set up an Arch installation with a 100 MB /boot partition
# and an encrypted LVM partition with swap and / inside.  It also installs
# and configures systemd as the init system (removing sysvinit).
#
# You should read through this script before running it in case you want to
# make any modifications, in particular, the variables just below, and the
# following functions:
#
#    partition_drive - Customize to change partition sizes (/boot vs LVM)
#    setup_lvm - Customize for partitions inside LVM
#    install_packages - Customize packages installed in base system
#                       (desktop environment, etc.)
#    install_aur_packages - More packages after packer (AUR helper) is
#                           installed
#    set_netcfg - Preload netcfg profiles
#}}}
# CONFIGURE THESE VARIABLES{{{
# Drive to install to.
DRIVE='/dev/sda'

# Hostname of the installed machine.
HOSTNAME='arch'

# Encrypt everything (except /boot).  Leave blank to disable.
ENCRYPT_DRIVE=''

# Passphrase used to encrypt the drive (leave blank to be prompted).
DRIVE_PASSPHRASE=''

# Root password (leave blank to be prompted).
ROOT_PASSWORD=''

# Main user to create (by default, added to wheel group, and others).
USER_NAME='lelgenio'
DOTFILES_URL='https://gitlab.com/lelgenio/dotfiles.git'
USER_SHELL='zsh'

# The main user's password (leave blank to be prompted).
USER_PASSWORD=''

# System timezone.
TIMEZONE='America/Sao_Paulo'

# Have /tmp on a tmpfs or not.  Leave blank to disable.
# Only leave this blank on systems with very little RAM.
TMP_ON_TMPFS='TRUE'

KEYMAP='br-abnt2'
# KEYMAP='dvorak'

LANG=pt_BR.UTF-8

# Choose your video driver
# For Intel
VIDEO_DRIVER="i915"
# For nVidia
#VIDEO_DRIVER="nouveau"
# For ATI
#VIDEO_DRIVER="radeon"
# For generic stuff
#VIDEO_DRIVER="vesa"

REMOVE_PKGS= false
FULL_INSTALL= false
#}}}
# PACKAGES{{{
    # sudo to allow to run as a user later
    sudo pacman -Sy 

    pkgs_base=''
    pkgs_base+=' base linux-zen linux-firmware intel-ucode lvm2 '
    pkgs_base+=' zsh networkmanager bluez cronie git man-db'
    pkgs_base+=" $(pacman -Qqg base-devel)"


    pkgs=''
    pkgs+=" $pkgs_base"
    # DE
    pkgs+=' sway waybar python-keyring light mako udiskie wofi-hg stow yay'
    pkgs+=' nemo redshift-wlr-gamma-control-git '
    pkgs+=' kitty neovim htop-vim-git'
    # Audio
    pkgs+=' pulseaudio pavolume-git'
    # Fonts
    pkgs+=' ttf-hack inter-font'
    if $FULL_INSTALL; then
        # Screenshot
        pkgs+=' grim slurp wl-clipboard wf-recorder-git'
        pkgs+=' httpie jq python-keepmenu-git'
        # Theme
        pkgs+=' materia-custom-accent papirus-icon-theme'
        pkgs+=' papirus-folders-git capitaine-cursors '
        # Terminal
        pkgs+=' tmux ranger atool p7zip tree'
        pkgs+=' neofetch powerline-fonts'
        pkgs+=' lolcat cmatrix'
        # Network
        pkgs+=' rsync rclone nmap gnu-netcat tor mtr speedtest-cli'
        # Browser
        pkgs+=' qutebrowser youtube-dl'
        # Email
        pkgs+=' evolution mutt-wizard-git neomutt' 
        # Files
        pkgs+=' syncthing nextcloud-client ' 
        pkgs+=' deluge deezloader-remix-bin smloadr' 
        # Media
        pkgs+=' mpv mpd mpc ncmpcpp '
        pkgs+=' blender gimp kdenlive picard image_optim' 
        # Office
        pkgs+=' libreoffice-fresh libreoffice-fresh-pt-br papirus-libreoffice-theme'
        # Programing
        pkgs+=' code neovim python-pynvim neovim-symlinks ipython how2'
        # Virt
        pkgs+=' qemu'
        # Gtk
        pkgs+=' gtk3-nocsd-git'
        # Qt
        pkgs+=' qt5-base qt5-wayland qt5ct kvantum-qt5'
        # Chat
        pkgs+=' discord telegram-desktop telegram-cli-git'
        # Gaming
        pkgs+=' steam lutris gamemode lutris-wine-meta wine wine-mono winetricks'
        if [ "$VIDEO_DRIVER" == "i915" ];then
            pkgs+=' xf86-video-intel '
            pkgs+=' lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader'
        elif [ "$VIDEO_DRIVER" == "radeon" ];then
            pkgs+=' xf86-video-ati'
            pkgs+='  lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader'
        elif [ "$VIDEO_DRIVER" == "nouveau" ];then
            pkgs+=' xf86-video-nouveau'
            pkgs+=' nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader'
        elif [ "$VIDEO_DRIVER" = "vesa" ];then
            packages+=' xf86-video-vesa'
        fi
    fi

#}}}
# Initial Setup{{{
# Base install{{{
setup() { 
    local boot_dev="$DRIVE"1
    local lvm_dev="$DRIVE"2

    echo 'Creating partitions'
    partition_drive "$DRIVE"

    if [ -n "$ENCRYPT_DRIVE" ]
    then
        local lvm_part="/dev/mapper/lvm"

        if [ -z "$DRIVE_PASSPHRASE" ]
        then
            echo 'Enter a passphrase to encrypt the disk:'
            stty -echo
            read DRIVE_PASSPHRASE
            stty echo
        fi

        echo 'Encrypting partition'
        encrypt_drive "$lvm_dev" "$DRIVE_PASSPHRASE" lvm

    else
        local lvm_part="$lvm_dev"
    fi

    echo 'Setting up LVM'
    setup_lvm "$lvm_part" vg00

    echo 'Formatting filesystems'
    format_filesystems "$boot_dev"

    echo 'Mounting filesystems'
    mount_filesystems "$boot_dev"

    echo 'Installing base system'
    install_base

    echo 'Chrooting into installed system to continue setup...'
    cp $0 /mnt/setup.sh
    arch-chroot /mnt ./setup.sh chroot

    if [ -f /mnt/setup.sh ]
    then
        echo 'ERROR: Something failed inside the chroot, not unmounting filesystems so you can investigate.'
        echo 'Make sure you unmount everything before you try to run this script again.'
    else
        echo 'Unmounting filesystems'
        unmount_filesystems
        echo 'Done! Reboot system.'
    fi
}
#}}}
# Partition Drive{{{
partition_drive() { 
    local dev="$1"; shift

    # 100 MB /boot partition, everything else under LVM
    parted -s "$dev" \
        mklabel gpt \
        mkpart boot 1    100M \
        mkpart lvm  100M 100% \
        set 1 boot on\
        set 2 lvm  on
}
#}}}
encrypt_drive #{{{
encrypt_drive() {
    local dev="$1"; shift
    local passphrase="$1"; shift
    local name="$1"; shift

    echo -en "$passphrase" | cryptsetup luksFormat "$dev"
    echo -en "$passphrase" | cryptsetup luksOpen "$dev" lvm
}
#}}}
# setup_lvm{{{
setup_lvm() {
    local partition="$1"; shift
    local volgroup="$1"; shift

    pvcreate "$partition"
    vgcreate "$volgroup" "$partition"

    # Create a 1GB swap partition
    lvcreate -C y -L1G "$volgroup" -n swap

    # Use the rest of the space for root
    lvcreate -L '30G' "$volgroup" -n root
    lvcreate -l '+100%FREE' "$volgroup" -n home

    # Enable the new volumes
    vgchange -ay
}
#}}}
# format_filesystems #{{{
format_filesystems() {
    local boot_dev="$1"; shift

    mkfs.fat  "$boot_dev"
    mkfs.ext4 -L root /dev/vg00/root
    mkfs.ext4 -L home /dev/vg00/home
    mkswap /dev/vg00/swap
}
#}}}
# mount_filesystems #{{{
mount_filesystems() {
    local boot_dev="$1"; shift

    mount /dev/vg00/root /mnt
    mkdir /mnt/home
    mount /dev/vg00/home /mnt/home
    mkdir /mnt/boot
    mount "$boot_dev" /mnt/boot
    swapon /dev/vg00/swap
}
#}}}
# install_base #{{{
install_base() {
    pacstrap /mnt $pkgs_base
}
#}}}
# unmount_filesystems #{{{
unmount_filesystems() {
    umount -R /mnt
    swapoff /dev/vg00/swap
    vgchange -an
    if [ -n "$ENCRYPT_DRIVE" ]
    then
        cryptsetup luksClose lvm
    fi
}
#}}}
#}}}
# Configuration{{{
# configure() {#{{{
configure() {
    local boot_dev="$DRIVE"1
    local lvm_dev="$DRIVE"2

    echo 'Setting repos'
    set_repos

    echo 'Setting hostname'
    set_hostname "$HOSTNAME"

    echo 'Setting timezone'
    set_timezone "$TIMEZONE"

    echo 'Setting locale'
    set_locale

    echo 'Setting console keymap'
    set_keymap

    echo 'Setting fstab'
    set_fstab "$TMP_ON_TMPFS" "$boot_dev"

    echo 'Configuring initial ramdisk'
    set_initcpio

    echo 'Setting initial daemons'
    set_daemons "$TMP_ON_TMPFS"

    echo 'Configuring Bluetooth'
    set_bluetooth 

    echo 'Configuring bootloader'
    set_bootctl "$lvm_dev"

    echo 'Configuring sudo'
    set_sudoers

    echo 'Configuring PAM'
    set_pam

    if [ -z "$ROOT_PASSWORD" ]
    then
        echo 'Enter the root password:'
        stty -echo
        read ROOT_PASSWORD
        stty echo
    fi
    echo 'Setting root password'
    set_root_password "$ROOT_PASSWORD"

    if [ -z "$USER_PASSWORD" ]
    then
        echo "Enter the password for user $USER_NAME"
        stty -echo
        read USER_PASSWORD
        stty echo
    fi
    echo 'Creating initial user'
    create_user "$USER_NAME" "$USER_PASSWORD"

    pacman -Syu 
    echo 'setting up user'
    cp $0 /home/$USER_NAME/setup.sh
    chown $USER_NAME /home/$USER_NAME/setup.sh
    su $USER_NAME -c /home/$USER_NAME/setup.sh
    rm /home/$USER_NAME/setup.sh

    echo 'Updating pkgfile database'
    update_pkgfile

    rm /setup.sh
}
#}}}
# set_repos() {{{{
set_repos() {
    # /etc/pacman.conf{{{
    cat > /etc/pacman.conf <<EOF
#
# GENERAL OPTIONS
#
[options]
HoldPkg     = pacman glibc
Architecture = auto

# Misc options
#UseSyslog
Color
#TotalDownload
CheckSpace
#VerbosePkgLists

SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

#
# REPOSITORIES
#

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist


#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

EOF
#}}}
# /etc/mirrorlist{{{
cat > /etc/mirrorlist <<EOF

# Server list generated by rankmirrors on 2019-11-24
# Brazil
Server = http://archlinux.c3sl.ufpr.br/$repo/os/$arch
Server = https://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = http://mirror.ufscar.br/archlinux/$repo/os/$arch
Server = http://br.mirror.archlinux-br.org/$repo/os/$arch
Server = http://mirror.ufam.edu.br/archlinux/$repo/os/$arch
Server = http://www.caco.ic.unicamp.br/archlinux/$repo/os/$arch
Server = http://linorg.usp.br/archlinux/$repo/os/$arch
Server = http://archlinux.pop-es.rnp.br/$repo/os/$arch
Server = http://pet.inf.ufsc.br/mirrors/archlinux/$repo/os/$arch

EOF
#}}}
}
#}}}
# set_hostname() {#{{{
set_hostname() {
    local hostname="$1"; shift

    echo "$hostname" > /etc/hostname

    cat > /etc/hosts <<EOF
127.0.0.1 localhost.localdomain localhost $hostname
::1       localhost.localdomain localhost $hostname
EOF
}
#}}}
# set_timezone() {#{{{
set_timezone() {
    local timezone="$1"; shift

    ln -sfT "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
}
#}}}
# set_locale() {#{{{
set_locale() {
    cat > /etc/locale.conf <<EOF
LANG=$LANG
LC_COLLATE=C
EOF

    cat > /etc/locale.gen <<EOF
en_US.UTF-8 UTF-8
$LANG       UTF-8
EOF

    locale-gen
}
#}}}
# set_keymap() {#{{{
set_keymap() {
    localectl set-keymap $KEYMAP
}
#}}}
# set_fstab() {#{{{
set_fstab() {
    local tmp_on_tmpfs="$1"; shift
    local boot_dev="$1"; shift

    local boot_uuid=$(get_uuid "$boot_dev")

    cat > /etc/fstab <<EOF
#
# /etc/fstab: static file system information
#
# <file system> <dir>    <type> <options>    <dump> <pass>

/dev/vg00/swap none     swap  sw                0 0
/dev/vg00/root /        ext4  rw,relatime 0 1
/dev/vg00/home /home    ext4  rw,relatime 0 2

UUID=$boot_uuid /boot ext2 defaults,relatime 0 2
EOF
}
#}}}
# set_initcpio() {#{{{
set_initcpio() {
    local vid

    if [ "$VIDEO_DRIVER" = "i915" ]
    then
        vid='i915'
    elif [ "$VIDEO_DRIVER" = "nouveau" ]
    then
        vid='nouveau'
    elif [ "$VIDEO_DRIVER" = "radeon" ]
    then
        vid='radeon'
    fi

    local encrypt=""
    if [ -n "$ENCRYPT_DRIVE" ]
    then
        encrypt="encrypt"
    fi

    cat > /etc/mkinitcpio.conf <<EOF
# vim:set ft=sh
MODULES=(ext4 $vid)

BINARIES=()

FILES=()

HOOKS=(base udev autodetect modconf block $encrypt lvm2 filesystems keyboard fsck)

EOF

    mkinitcpio -P
}
#}}}
# set_daemons() {#{{{
set_daemons() {
    local tmp_on_tmpfs="$1"; shift

    systemctl enable cronie.service NetworkManager.service

    if [ -z "$tmp_on_tmpfs" ]
    then
        systemctl mask tmp.mount
    fi
}
#}}}
# set_bluetooth{{{
set_bluetooth() {
    cat >> /etc/bluetooth/main.conf <<EOF

[General]
DiscoverableTimeout = 0
Discoverable = true

AlwaysPairable = true

[Policy]
AutoEnable=true

EOF
}
#}}}
# set_bootctl() {#{{{
set_bootctl() {
    local lvm_dev="$1"; shift

    local lvm_uuid=$(get_uuid "$lvm_dev")

    local crypt=""
    if [ -n "$ENCRYPT_DRIVE" ]
    then
        # Load in resources
        crypt="root=UUID=$lvm_uuid"
    fi

    bootctl install
    cat > /boot/loader/entries/arch.conf <<EOF
title arch

linux vmlinuz-linux-zen
initrd intel-ucode.img
initrd initramfs-linux-zen.img

options $crypt
#options quiet splash loglevel=3 rd.udev.log_priority=3 vt.global_cursor_default=0 $crypt
EOF

}
#}}}
# set_sudoers() {#{{{
set_sudoers() {
    cat > /etc/sudoers <<EOF
##
## User privilege specification
##
root ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL

## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL


## Read drop-in files from /etc/sudoers.d
## (the '#' here does not indicate a comment)
#includedir /etc/sudoers.d
EOF

    chmod 440 /etc/sudoers
}
#}}}
# set_pam{{{
set_pam() {
    cat >> /etc/pam.d/login <<EOF
session    optional     pam_gnome_keyring.so auto_start
EOF
}
#}}}
# set_root_password() {#{{{
set_root_password() {
    local password="$1"; shift

    echo -en "$password\n$password" | passwd
}
#}}}
# create_user() {#{{{
create_user() {
    local name="$1"; shift
    local password="$1"; shift

    useradd -m -s /usr/bin/$USER_SHELL -G adm,systemd-journal,wheel,rfkill,games,network,video,audio,optical,floppy,storage,scanner,power "$name"
    echo -en "$password\n$password" | passwd "$name"
}
#}}}
# update_pkgfile() {#{{{
update_pkgfile() {
    pkgfile -u
}
#}}}
# get_uuid() {#{{{
get_uuid() {
    blkid -o export "$1" | grep UUID | awk -F= '{print $2}'
}
#}}}
#}}}
# User setup{{{
user_setup() {

    echo 'Installing packages'
    install_aur_packages

    if $REMOVE_PKGS;then
        echo 'Cleaning packages'
        clean_packages
    fi

    echo 'Stowing dotfiles'
    stow_dots
}
# Install AUR packages #{{{
install_aur_packages() {

    sudo pacman -S --needed git

    # getting yay
    if [ ! -x /bin/yay ];
    then
        git clone http://aur.archlinux.org/yay.git ~/yay
        cd ~/yay
        makepkg -si --noconfirm
        cd -
    fi

    yay -Syu --noconfirm --needed $pkgs
}
#}}}
# Clean up packages #{{{
clean_packages() {
    yay -D --asdeps $(yay -Qqe)
    yay -D --asexplicit $pkgs
    TO_REMOVE=$(yay -Qtdq)
    if [ -n "$TO_REMOVE" ];then
        yay -Rns --noconfirm $TO_REMOVE
    fi
    yay -Scc --noconfirm
}
#}}}
# Stow dotfiles{{{
stow_dots() {
    if [ ! -d  ~/.dotfiles ];then
        git clone $DOTFILES_URL ~/.dotfiles
    fi
    cd ~/.dotfiles
    if [ -f "~/.config/mimeapps.list" ];then
        rm ~/.config/mimeapps.list
    fi
    stow */
    cp mime/.config/mimeapps.list ~/.config/mimeapps.list
    cd -
}
#}}}
#}}}
set -ex

if [ ! "$USER" == "root"  ];then
    user_setup
elif [ "$1" == "chroot" ];then
    configure
else
    setup
fi

# vim:foldmethod=marker
