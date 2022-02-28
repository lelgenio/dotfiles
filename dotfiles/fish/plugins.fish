# {{@@ header() @@}}

##################################################
# fundle fish plugin manager
##################################################

if not functions -q fundle
    and test "$USER" != root
    eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin 'FabioAntunes/fish-nvm'
fundle plugin 'edc/bass'
fundle init


################################################################
# Source .env files
################################################################

command -qs direnv &&
    direnv hook fish | source


##################################################
# asdf Version manager
##################################################

if not test -d ~/.asdf
    and test "$USER" != root
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
    mkdir -p ~/.config/fish/completions
    and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

    source ~/.asdf/asdf.fish

    asdf plugin add nodejs &> /dev/null
    asdf install nodejs 12.13.1 &> /dev/null
    asdf install nodejs latest &> /dev/null
    asdf global nodejs latest &> /dev/null

    asdf plugin add rust &> /dev/null
    asdf install rust nightly &> /dev/null
    asdf global rust nightly &> /dev/null
end

test -f ~/.asdf/asdf.fish
and source ~/.asdf/asdf.fish


##################################################
# Prompt
##################################################

{%@@ if starship @@%}
    starship init fish | source
    # Set cursor shape
    printf '\e[5 q' # Bar
{%@@ else @@%}
    source {$__fish_config_dir}/prompt.fish
{%@@ endif @@%}
