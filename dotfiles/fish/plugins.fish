set -l NVM_URL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh"
if not test -d "$NVM_DIR"
    and test "$USER" != root
    set -e nvm_prefix
    mkdir -p "$NVM_DIR"
    curl -o- "$NVM_URL" | bash
end

if not functions -q fundle
    and test "$USER" != root
    eval (curl -sfL https://git.io/fundle-install)
end
fundle plugin 'FabioAntunes/fish-nvm'
fundle plugin 'edc/bass'
fundle init

{%@@ if starship @@%}
    starship init fish | source
    # Set cursor shape
    printf '\e[5 q' # Bar
{%@@ else @@%}
    source {$__fish_config_dir}/prompt.fish
{%@@ endif @@%}
