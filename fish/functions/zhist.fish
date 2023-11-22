function zhist
    commandline (cat ~/.zsh_history | awk -F ';' '{print $2}' | sk)
end
