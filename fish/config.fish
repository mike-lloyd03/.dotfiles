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
    # set -x MANPATH /usr/local/opt/gnuman:${MANPATH:-/usr/share/man}
    # set -x KUBECONFIG "$HOME/.kube/config:$HOME/.kube/config-dev"
end

if [ "$(uname -n)" = dev ]
    # set -x KUBECONFIG "$HOME/.kube/config:$HOME/.kube/config-dev"
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

# Prompt
if status is-interactive
    function starship_transient_prompt_func
        starship module line_break
        starship module character
    end
    starship init fish | source
    enable_transience

    atuin init fish --disable-up-arrow | source

    zoxide init fish --cmd cd | source


    if command -v direnv &> /dev/null
        direnv hook fish | source
    end
end
