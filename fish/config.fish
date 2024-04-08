source "$HOME/.config/fish/aliases.fish"

# vim bindings
fish_vi_key_bindings
set fish_vi_force_cursor true
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

# Environment
if command -v nvimpager > /dev/null
    set -Ux PAGER nvimpager
else
    set -Ux PAGER less
end

set -Ux EDITOR nvim
set -U fish_greeting ""

if [ "$(uname -n)" = "TD-C02FK3H8MD6T" ]
    fish_add_path "/usr/local/opt/gnubin:/usr/local/bin"
end

if [ "$(uname -n)" = dev ]
    set -x GOPRIVATE github.td.teradata.com
end

if [ "$(uname -n)" = kratos ]
    set -x ANDROID_HOME "$HOME/Android/Sdk"
end

# Keybinds
bind --mode default \co edit_command_buffer
bind --mode insert \co edit_command_buffer

# Path
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# Nix
if command -v nix > /dev/null
    fish_add_path $HOME/.nix-profile/bin
end

# Prompt
if status is-interactive
    if command -v starship > /dev/null
        function starship_transient_prompt_func
            starship module line_break
            starship module custom.corner_top
            starship module username
            starship module hostname
            starship module directory
            starship module line_break
            starship module custom.corner_bot
            starship module character
        end
        function starship_transient_rprompt_func
            starship module time
        end
        starship init fish | source
        enable_transience
    end

    if command -v zoxide > /dev/null
        atuin init fish --disable-up-arrow | source
    end

    if command -v zoxide > /dev/null
        zoxide init fish --cmd cd | source
    end

    if command -v direnv &> /dev/null
        direnv hook fish | source
    end
end
