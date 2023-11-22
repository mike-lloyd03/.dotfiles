function fishconf
    set config_dir "$HOME/.config/fish"
    set edit_file "$argv[1]"

    if [ -z $edit_file ]
        pushd $config_dir >/dev/null && nvim "$config_dir/config.fish" && popd >/dev/null
        return 0
    end

    if find "$config_dir/" -name "*.fish" | grep -P "$config_dir/$edit_file.fish" >/dev/null
        pushd $config_dir >/dev/null && nvim "$config_dir/$edit_file.fish" && popd >/dev/null
    else
        echo "$edit_file.fish not found in fish config directory"
    end
end

complete -c fishconf -a "$(ls ~/.config/fish/ | grep -P '.*\.fish$' | string replace '.fish' '')" -f
