function mpedit
    set workdir "$HOME/.config/metapac"
    set edit_file "$argv[1]"
    set edit_path ""

    if [ "$edit_file" = "" ]
        set edit_path "$workdir/groups/default.toml"
    else if [ "$edit_file" = "config" ]
        set edit_path "$workdir/config.toml"
    else
        if find "$workdir/groups" -name "*.toml" | grep -P "$workdir/groups/$edit_file.toml" >/dev/null
            set edit_path "$workdir/groups/$edit_file.toml"
        end
    end


    if [ "$edit_path" = "" ]
        echo "$edit_file.toml not found in metapac config directory"
        return 1
    else
        pushd $workdir >/dev/null && nvim "$edit_path" && popd >/dev/null
    end
end
