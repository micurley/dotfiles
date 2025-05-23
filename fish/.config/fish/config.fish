if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vim='nvim'
    set -gx EDITOR vim
    set -gx GITHUB_TOKEN *********************************************************************************************

    alias rf='source ~/.config/fish/config.fish'

    test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

    eval "$(/opt/homebrew/bin/brew shellenv)"
    eval "$(zoxide init fish)"
    # thefuck
    thefuck --alias | source
    thefuck --alias fk | source

    # Starship
    # starship init fish | source

    # FZF intergration
    # PatrickF1/fzf.fish
    fzf_configure_bindings
    #
    # Disabling vim mode b/c I don't really use
    fish_vi_key_bindings

    # Support NVM
    source ~/.config/fish/functions/nvm.fish/nvm.fish

    function __nvm_auto_use --on-variable PWD
        if test -f .nvmrc
            set version (string trim (cat .nvmrc))
            nvm use $version >/dev/null
        end
    end
end

# Created by `pipx` on 2025-02-06 16:36:50
set PATH $PATH /Users/morgancurley/.local/bin
