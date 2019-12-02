# LEL

#          _     
#  _______| |__  
# |_  / __| '_ \ 
#  / /\__ \ | | |
# /___|___/_| |_|
               
# Environment Vairables {{{
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH=$PATH:~/.local/bin

export EDITOR=nvim
export VISUAL=nvim
# export BROWSER=qutebrowser
export PAGER=less

#}}}
# set window title {{{
#
    autoload -Uz add-zsh-hook

    function xterm_title_precmd () {
        print -Pn -- '\e]2;%n@%m %~\a'
    }

    function xterm_title_preexec () {
        print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
    }

    if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
        add-zsh-hook -Uz precmd xterm_title_precmd
        add-zsh-hook -Uz preexec xterm_title_preexec
    fi
# }}}
# start sway if using tty1 {{{
#
    esway() {
        clear
        # export XDG_CURRENT_DESKTOP=Unity
        export QT_SCALE_FACTOR=1
        export QPA_PLATFORM=wayland
        export QT_QPA_PLATFORM=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export GTK_CSD=0
        export LD_PRELOAD=/usr/lib/libgtk3-nocsd.so.0
        export XCURSOR_THEME=capitaine-cursors
        export SWAY=1
        exec sway
    }
    if [[ $XDG_VTNR -eq 1 ]] #faster like this
    then
        if systemctl -q is-active graphical.target && [[ ! $DISPLAY ]]
        then
            esway
        fi
    fi

# }}}
# use tmux{{{

if [ -z "$TMUX" ] && [ "$TERM" != "xterm-kitty" ]; then
    attach_session=$(tmux 2> /dev/null ls -F \
        '#{session_attached} #{?#{==:#{session_last_attached},},1,#{session_last_attached}} #{session_id}' |
        awk '/^0/ { if ($2 > t) { t = $2; s = $3 } }; END { if (s) printf "%s", s }')
    if [ -n "$attach_session" ]
    then
        exec tmux attach -t "$attach_session"
    else
        exec tmux
    fi
fi

# }}}
# Plugins {{{
#
	export ZPLUG_HOME=~/.local/share/zplug
	if [ ! -d $ZPLUG_HOME ]
	then
		git clone https://github.com/zplug/zplug $ZPLUG_HOME
	fi
	source $ZPLUG_HOME/init.zsh
	zplug 'zplug/zplug', hook-build:'zplug --self-manage'

    zplug "zsh-users/zsh-completions"

    # History
    zplug "scripts/dirhistory", from:oh-my-zsh
	zplug "zsh-users/zsh-history-substring-search"
    HISTFILE=~/.histfile
    HISTSIZE=1000
    SAVEHIST=1000

    # sugestões automaticas
	zplug "momo-lab/zsh-abbrev-alias"
	zplug "zsh-users/zsh-syntax-highlighting", defer:2
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=black"
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=true
    zplug "zsh-users/zsh-autosuggestions"

    # Promp config
	bindkey -e 
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_CHAR_SYMBOL='$ '
    SPACESHIP_CHAR_SYMBOL_ROOT='# '
	zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
	
    if ! zplug check
    then
        zplug install
    fi

    zplug load

# }}}
# Aliases {{{
#
    abbrev-alias -g v=nvim
    abbrev-alias -g rv="sudo nvim"
    abbrev-alias  es="nvim ~/.config/sway/config"
    abbrev-alias  ez="nvim ~/.zshrc"
    abbrev-alias  ev="nvim ~/.config/nvim/init.vim"
    abbrev-alias  r=ranger
    abbrev-alias  rm=trash
    abbrev-alias  suspend="systemctl suspend"
    abbrev-alias  tlsave='telegram-cli -We "send_document @lelgenio "'

    alias         emacs='env TERM=xterm-256color /usr/bin/emacs -nw'
    abbrev-alias  em='emacs -nw'

    abbrev-alias -i 
    alias ls='ls --color=auto --human-readable --group-directories-first --classify'
    alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
    alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'

    man() {
        LESS_TERMCAP_md=$'\e[01;31m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[01;44;33m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[01;32m' \
        command man "$@"
    }

# }}}
# Keys. {{{
#
    autoload -z edit-command-line
    zle -N edit-command-line
    bindkey "^X^E" edit-command-line

    case $TERM in
        rxvt*|xterm*)
            bindkey "^[[H" beginning-of-line #Home key
            bindkey "^[[F" end-of-line #End key
            bindkey "^[[3~" delete-char #Del key
            bindkey "^[[A" history-substring-search-up #Up Arrow
            bindkey "^[[B" history-substring-search-down #Down Arrow
            bindkey "^[Oc" forward-word # control + right arrow
            bindkey "^[Od" backward-word # control + left arrow
            bindkey "^H" backward-kill-word # control + backspace
            bindkey "^[[3^" kill-word # control + delete
        ;;
        linux)
            bindkey "^[[1~" beginning-of-line #Home key
            bindkey "^[[4~" end-of-line #End key
            bindkey "^[[3~" delete-char #Del key
            bindkey "^[[A" history-beginning-search-backward
            bindkey "^[[B" history-beginning-search-forward
        ;;
        screen|screen-*)
            bindkey "^[[1~" beginning-of-line #Home key
            bindkey "^[[4~" end-of-line #End key
            bindkey "^[[3~" delete-char #Del key
            bindkey "^[[A" history-beginning-search-backward #Up Arrow
            bindkey "^[[B" history-beginning-search-forward #Down Arrow
            bindkey "^[Oc" forward-word # control + right arrow
            bindkey "^[OC" forward-word # control + right arrow
            bindkey "^[Od" backward-word # control + left arrow
            bindkey "^[OD" backward-word # control + left arrow
            bindkey "^H" backward-kill-word # control + backspace
            bindkey "^[[3^" kill-word # control + delete
        ;;
    esac


# }}}
# Completions {{{
#
    HYPHEN_INSENSITIVE="true"
    ENABLE_CORRECTION="true"

    COMPLETION_WAITING_DOTS="true"
    zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
    zstyle ':completion:*' group-name ''
    zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    zstyle ':completion:*' menu select=list select=0
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion:*' use-compctl true
    zstyle ':completion:*' verbose true
    zstyle ':completion:*' rehash true
    zstyle :compinstall filename '/home/lelgenio/.config//zsh//.zshrc'
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    source /usr/share/doc/pkgfile/command-not-found.zsh

    autoload -Uz compinit
    compinit

    setopt GLOBSTARSHORT
#}}}

# vim:foldmethod=marker
