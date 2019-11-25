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
# PACKAGES{{{
    sudo pacman -Sy 

    pkgs_base=''
    pkgs_base+=' base linux-zen linux-firmware intel-ucode lvm2 '
    pkgs_base+=' zsh networkmanager bluez cronie git man-db'
    pkgs_base+=" $(pacman -Qqg base-devel)"


    pkgs=''
    pkgs+=" $pkgs_base"
    # DE
    pkgs+=' sway light mako udiskie wofi-hg stow yay pamac-aur'
    pkgs+=' nemo redshift-wlr-gamma-control-git '
    pkgs+=' htop-vim-git'
    # Screenshot
    pkgs+=' grim slurp wl-clipboard wf-recorder-git'
    # Audio
    pkgs+=' pulseaudio pavolume-git'
    pkgs+=' httpie jq python-keepmenu-git'
    # Fonts
    pkgs+=' ttf-hack inter-font'
    # Theme
    pkgs+=' materia-custom-accent papirus-icon-theme'
    pkgs+=' papirus-folders-git capitaine-cursors '
    # Terminal
    pkgs+=' kitty neovim tmux ranger atool p7zip tree'
    pkgs+=' zsh neofetch powerline-fonts'
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

REMOVE_PKGS='FALSE'
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
    umount /mnt/boot
    umount /mnt
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
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
#HookDir     = /etc/pacman.d/hooks/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -L -C - -f -o %o %u
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
#UseDelta    = 0.7
Architecture = auto

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
Color
#TotalDownload
CheckSpace
#VerbosePkgLists

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with `pacman-key --populate archlinux`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

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

# If you want to run 32 bit applications on your x86_64 system,
# enable the multilib repositories as required here.

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs
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
# MODULES
# The following modules are loaded before any boot hooks are
# run.  Advanced users may wish to specify all system modules
# in this array.  For instance:
#     MODULES=(piix ide_disk reiserfs)
MODULES=(ext4 $vid)

# BINARIES
# This setting includes any additional binaries a given user may
# wish into the CPIO image.  This is run last, so it may be used to
# override the actual binaries included by a given hook
# BINARIES are dependency parsed, so you may safely ignore libraries
BINARIES=()

# FILES
# This setting is similar to BINARIES above, however, files are added
# as-is and are not parsed in any way.  This is useful for config files.
FILES=()

# HOOKS
# This is the most important setting in this file.  The HOOKS control the
# modules and scripts added to the image, and what happens at boot time.
# Order is important, and it is recommended that you do not change the
# order in which HOOKS are added.  Run 'mkinitcpio -H <hook name>' for
# help on a given hook.
# 'base' is _required_ unless you know precisely what you are doing.
# 'udev' is _required_ in order to automatically load modules
# 'filesystems' is _required_ unless you specify your fs modules in MODULES
# Examples:
##   This setup specifies all modules in the MODULES setting above.
##   No raid, lvm2, or encrypted root is needed.
#    HOOKS=(base)
#
##   This setup will autodetect all modules for your system and should
##   work as a sane default
#    HOOKS=(base udev autodetect block filesystems)
#
##   This setup will generate a 'full' image which supports most systems.
##   No autodetection is done.
#    HOOKS=(base udev block filesystems)
#
##   This setup assembles a pata mdadm array with an encrypted root FS.
##   Note: See 'mkinitcpio -H mdadm' for more information on raid devices.
#    HOOKS=(base udev block mdadm encrypt filesystems)
#
##   This setup loads an lvm2 volume group on a usb device.
#    HOOKS=(base udev block lvm2 filesystems)
#
##   NOTE: If you have /usr on a separate partition, you MUST include the
#    usr, fsck and shutdown hooks.
HOOKS=(base udev autodetect modconf block $encrypt lvm2 filesystems keyboard fsck)

# COMPRESSION
# Use this to compress the initramfs image. By default, gzip compression
# is used. Use 'cat' to create an uncompressed image.
#COMPRESSION="gzip"
#COMPRESSION="bzip2"
#COMPRESSION="lzma"
#COMPRESSION="xz"
#COMPRESSION="lzop"
#COMPRESSION="lz4"

# COMPRESSION_OPTIONS
# Additional options for the compressor
#COMPRESSION_OPTIONS=()
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

# Default adapter name
# Defaults to 'BlueZ X.YZ'
#Name = BlueZ

# Default device class. Only the major and minor device class bits are
# considered. Defaults to '0x000000'.
#Class = 0x000100

# How long to stay in discoverable mode before going back to non-discoverable
# The value is in seconds. Default is 180, i.e. 3 minutes.
# 0 = disable timer, i.e. stay discoverable forever
DiscoverableTimeout = 0
Discoverable = true

# Always allow pairing even if there are no agent registered
# Possible values: true, false
# Default: false
AlwaysPairable = true

# How long to stay in pairable mode before going back to non-discoverable
# The value is in seconds. Default is 0.
# 0 = disable timer, i.e. stay pairable forever
#PairableTimeout = 0

# Use vendor id source (assigner), vendor, product and version information for
# DID profile support. The values are separated by ":" and assigner, VID, PID
# and version.
# Possible vendor id source values: bluetooth, usb (defaults to usb)
#DeviceID = bluetooth:1234:5678:abcd

# Do reverse service discovery for previously unknown devices that connect to
# us. For BR/EDR this option is really only needed for qualification since the
# BITE tester doesn't like us doing reverse SDP for some test cases, for LE
# this disables the GATT client functionally so it can be used in system which
# can only operate as peripheral.
# Defaults to 'true'.
#ReverseServiceDiscovery = true

# Enable name resolving after inquiry. Set it to 'false' if you don't need
# remote devices name and want shorter discovery cycle. Defaults to 'true'.
#NameResolving = true

# Enable runtime persistency of debug link keys. Default is false which
# makes debug link keys valid only for the duration of the connection
# that they were created for.
#DebugKeys = false

# Restricts all controllers to the specified transport. Default value
# is "dual", i.e. both BR/EDR and LE enabled (when supported by the HW).
# Possible values: "dual", "bredr", "le"
#ControllerMode = dual

# Enables Multi Profile Specification support. This allows to specify if
# system supports only Multiple Profiles Single Device (MPSD) configuration
# or both Multiple Profiles Single Device (MPSD) and Multiple Profiles Multiple
# Devices (MPMD) configurations.
# Possible values: "off", "single", "multiple"
#MultiProfile = off

# Permanently enables the Fast Connectable setting for adapters that
# support it. When enabled other devices can connect faster to us,
# however the tradeoff is increased power consumptions. This feature
# will fully work only on kernel version 4.1 and newer. Defaults to
# 'false'.
#FastConnectable = false

# Default privacy setting.
# Enables use of private address.
# Possible values: "off", "device", "network"
# "network" option not supported currently
# Defaults to "off"
# Privacy = off

[GATT]
# GATT attribute cache.
# Possible values:
# always: Always cache attributes even for devices not paired, this is
# recommended as it is best for interoperability, with more consistent
# reconnection times and enables proper tracking of notifications for all
# devices.
# yes: Only cache attributes of paired devices.
# no: Never cache attributes
# Default: always
#Cache = always

# Minimum required Encryption Key Size for accessing secured characteristics.
# Possible values: 0 and 7-16. 0 means don't care.
# Defaults to 0
#KeySize = 0

# Exchange MTU size.
# Possible values: 23-517
# Defaults to 517
#ExchangeMTU = 517

[Policy]
#
# The ReconnectUUIDs defines the set of remote services that should try
# to be reconnected to in case of a link loss (link supervision
# timeout). The policy plugin should contain a sane set of values by
# default, but this list can be overridden here. By setting the list to
# empty the reconnection feature gets disabled.
#ReconnectUUIDs=00001112-0000-1000-8000-00805f9b34fb,0000111f-0000-1000-8000-00805f9b34fb,0000110a-0000-1000-8000-00805f9b34fb

# ReconnectAttempts define the number of attempts to reconnect after a link
# lost. Setting the value to 0 disables reconnecting feature.
#ReconnectAttempts=7

# ReconnectIntervals define the set of intervals in seconds to use in between
# attempts.
# If the number of attempts defined in ReconnectAttempts is bigger than the
# set of intervals the last interval is repeated until the last attempt.
#ReconnectIntervals=1,2,4,8,16,32,64

# AutoEnable defines option to enable all controllers when they are found.
# This includes adapters present on start as well as adapters that are plugged
# in later on. Defaults to 'false'.
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
## sudoers file.
##
## This file MUST be edited with the 'visudo' command as root.
## Failure to use 'visudo' may result in syntax or file permission errors
## that prevent sudo from running.
##
## See the sudoers man page for the details on how to write a sudoers file.
##

##
## Host alias specification
##
## Groups of machines. These may include host names (optionally with wildcards),
## IP addresses, network numbers or netgroups.
# Host_Alias	WEBSERVERS = www1, www2, www3

##
## User alias specification
##
## Groups of users.  These may consist of user names, uids, Unix groups,
## or netgroups.
# User_Alias	ADMINS = millert, dowdy, mikef

##
## Cmnd alias specification
##
## Groups of commands.  Often used to group related commands together.
# Cmnd_Alias	PROCESSES = /usr/bin/nice, /bin/kill, /usr/bin/renice, \
# 			    /usr/bin/pkill, /usr/bin/top
# Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff

##
## Defaults specification
##
## You may wish to keep some of the following environment variables
## when running commands via sudo.
##
## Locale settings
# Defaults env_keep += "LANG LANGUAGE LINGUAS LC_* _XKB_CHARSET"
##
## Run X applications through sudo; HOME is used to find the
## .Xauthority file.  Note that other programs use HOME to find   
## configuration files and this may lead to privilege escalation!
# Defaults env_keep += "HOME"
##
## X11 resource path settings
# Defaults env_keep += "XAPPLRESDIR XFILESEARCHPATH XUSERFILESEARCHPATH"
##
## Desktop path settings
# Defaults env_keep += "QTDIR KDEDIR"
##
## Allow sudo-run commands to inherit the callers' ConsoleKit session
# Defaults env_keep += "XDG_SESSION_COOKIE"
##
## Uncomment to enable special input methods.  Care should be taken as
## this may allow users to subvert the command being run via sudo.
# Defaults env_keep += "XMODIFIERS GTK_IM_MODULE QT_IM_MODULE QT_IM_SWITCHER"
##
## Uncomment to use a hard-coded PATH instead of the user's to find commands
# Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
##
## Uncomment to send mail if the user does not enter the correct password.
# Defaults mail_badpass
##
## Uncomment to enable logging of a command's output, except for
## sudoreplay and reboot.  Use sudoreplay to play back logged sessions.
# Defaults log_output
# Defaults!/usr/bin/sudoreplay !log_output
# Defaults!/usr/local/bin/sudoreplay !log_output
# Defaults!REBOOT !log_output

##
## Runas alias specification
##

##
## User privilege specification
##
root ALL=(ALL) ALL

## Uncomment to allow members of group wheel to execute any command
# %wheel ALL=(ALL) ALL

## Same thing without a password
%wheel ALL=(ALL) NOPASSWD: ALL

## Uncomment to allow members of group sudo to execute any command
# %sudo	ALL=(ALL) ALL

## Uncomment to allow any user to run sudo if they know the password
## of the user they are running the command as (root by default).
# Defaults targetpw  # Ask for the password of the target user
# ALL ALL=(ALL) ALL  # WARNING: only use this together with 'Defaults targetpw'

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

    if [ "$REMOVE_PKGS" == "TRUE" ];then
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
